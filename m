Return-Path: <stable+bounces-185745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B72BDC31B
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 04:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8FA3C1B74
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 02:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEBC30C349;
	Wed, 15 Oct 2025 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lQYyftFi"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D9430C36F
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496271; cv=none; b=q+U5ZRtybPGv+Qis0IgI9XpZvRG/yPz0XVVMEu6QfySwGqTkYuMq0J/zT96PFKSmfBEHuXQoTB3DBibBlUIJsKMi1RYj9byLwTT3iUPgELt4bms+NV3TcM8NcpNDlxzGhR9BgTObmmRDvF5uTML0ZGfqmxgGemBQ+Lso20sykcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496271; c=relaxed/simple;
	bh=UltKhUBA2PT2AThZpuw9jXeuz08xYSSw6U+mLO9ZVB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4GUWIFn6b/10Pf7e3K//71KlwIWqkitHVSmm7Z8oQ/2Y1EhnQKeRG3lIT1FYXvSqjzCXDCtSCgBq51fBmiZBYRn4Fj4XVtDS+MRLT3FIWktkaO2UYQdAcOMPV+cUnqwsxZfNr8gT+Z9eeMSvvBiZGhE7HmAa/IWvM4KLgmKv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lQYyftFi; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-184.bstnma.fios.verizon.net [173.48.113.184])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59F2iJo6021692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 22:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760496261; bh=mGkHoVrEVhRx3CyyvTLDmPkWko8VZjos3xWaPk6ItfU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=lQYyftFit6YXfKMpqmrLmS/Cl+qtBjw0n18xt8kKh9HvNoL5m3N7vjuEcLxjrwRgw
	 +2WnXPICBy5e994VVGWIvUARW4geHRy3uiicHu/d2uwLbOUXNss2oz4V1q62lOBP0C
	 RL3N6czPetxAGlA0HgIWUUunwILIsNc2zptbzZ4n/iWlqiftWLoIU1ygqZrTiNjk4k
	 o6QOgxEu4G9NIG+w3GPBg3+3yiFxAFY9hrIwKkCZAvANBNm4PsqolZDPDflHmJ1oAs
	 e4NFvK26tHihs5AV6RFMw/iTwDhr8aHawnpyc8PNRVBGFjPCpq6A9MvrESw8J6WVQw
	 MRN8p7ZpqK+Kg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3C14A2E00D9; Tue, 14 Oct 2025 22:44:19 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Chris Mason <clm@meta.com>, stable@vger.kernel.org
Subject: Re: [PATCH] ext4: free orphan info with kvfree
Date: Tue, 14 Oct 2025 22:44:12 -0400
Message-ID: <176049624801.779602.3237597596119501431.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007134936.7291-2-jack@suse.cz>
References: <20251007134936.7291-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 07 Oct 2025 15:49:37 +0200, Jan Kara wrote:
> Orphan info is now getting allocated with kvmalloc_array(). Free it with
> kvfree() instead of kfree() to avoid complaints from mm.
> 
> 

Applied, thanks!

[1/1] ext4: free orphan info with kvfree
      commit: 971843c511c3c2f6eda96c6b03442913bfee6148

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

