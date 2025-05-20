Return-Path: <stable+bounces-145680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D9EABDDFE
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F01D18975AB
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031824E4DD;
	Tue, 20 May 2025 14:57:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966E24EAA3
	for <stable@vger.kernel.org>; Tue, 20 May 2025 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753061; cv=none; b=tRXkqd1RQtQZfp/4rTsgxLVAejD8u1UIPWkA3g2MNcv6htB95v/nN9S7A7fUl8gFdqbRPuf0ZqHBVYdluyTIw23irY48KZwXbq4vTUQGRaZ9H1evkrHzy9DBWwf2gMTlUtv5poc0RRm/lOPK18NK+/B92K/lphaj/umFHWfHQqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753061; c=relaxed/simple;
	bh=DRecNgekukf6fwKtatb8GKkZlAmeQpmIOZSC5KLUQ5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqGr9hMhxTYESmOyJDTaB29VAHQHygFlZkZgqrBsn+fnNPEG687uobQFNypJSfZFB0qGCFsLc8n4AViDAPTKEtbYV8Ta/DGDXgoPgsxhQyEQW2TqfPhjTgi5zGJINmonUsIaB1i+AMBFN++kkGhoOpvxmRP5RI79nFYQaUVP0zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54KEv87l018007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:57:09 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 85A842E00DD; Tue, 20 May 2025 10:57:08 -0400 (EDT)
Date: Tue, 20 May 2025 10:57:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Jan Kara <jack@suse.com>, Tao Ma <boyu.mt@taobao.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Eric Biggers <ebiggers@google.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com,
        syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] ext4: inline: do not convert when writing to memory map
Message-ID: <20250520145708.GA432950@mit.edu>
References: <20250519-ext4_inline_page_mkwrite-v1-1-865d9a62b512@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519-ext4_inline_page_mkwrite-v1-1-865d9a62b512@igalia.com>

On Mon, May 19, 2025 at 07:42:46AM -0300, Thadeu Lima de Souza Cascardo wrote:
> inline data handling has a race between writing and writing to a memory
> map.
> 
> When ext4_page_mkwrite is called, it calls ext4_convert_inline_data, which
> destroys the inline data, but if block allocation fails, restores the
> inline data. In that process, we could have:
> 
> CPU1					CPU2
> destroy_inline_data
> 					write_begin (does not see inline data)
> restory_inline_data
> 					write_end (sees inline data)
> 
> The conversion inside ext4_page_mkwrite was introduced at commit
> 7b4cc9787fe3 ("ext4: evict inline data when writing to memory map"). This
> fixes a documented bug in the commit message, which suggests some
> alternatives fixes.

Your fix just reverts commit 7b4cc9787fe3, and removes the BUG_ON.
While this is great for shutting up the syzbot report, but it causes
file writes to an inline data file via a mmap to never get written
back to the storage device.  So you are replacing BUG_ON that can get
triggered on a race condition in case of a failed block allocation,
with silent data corruption.   This is not an improvement.

Thanks for trying to address this, but I'm not going to accept your
proposed fix.

     	    	 	       	       - Ted

