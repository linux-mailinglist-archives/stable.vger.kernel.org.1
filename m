Return-Path: <stable+bounces-43502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720548C1183
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 16:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35911C20C39
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953F915E1F8;
	Thu,  9 May 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dqCnAh1B"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4913C668
	for <stable@vger.kernel.org>; Thu,  9 May 2024 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266304; cv=none; b=m7sC5cs84nUFMCNcASRoYEsSnaRsTVrhd2uIiod47/+M9l0MwF4JdRmx3zfkqX2qUzR5QXJJQUao401+XR5hUwRSOCIHsbgP7pK5+EX4wcaNJgSTLOJk5w3wwekU0wbgstt0/kMTflWTWwc1YTiNfRCxkfWiJUH2bH6+kqPyn+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266304; c=relaxed/simple;
	bh=ROuxEhTpbRtsfE1hnzOUvo+e32DRlMNGBViWysD4b0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ne0Q+3V0NTT9k6daYdZuqyGduDacEqEZv2dwrKqZM1/nVoYe1zWfnEW8Y+7FYviOcZKzVu3VBf0QieddVDRpBkFKGWKyYRAaUSIlhJCgLfNcqBYBf/1wFPGdKaNXqroBZ8pNDkuNncsQ8gzaXwvckaET5vqTe5+f41xfcMCSVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dqCnAh1B; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 449EpO0m025071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 10:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715266288; bh=2rkEFPmAsmSs8bT9V5fpjO3Bmf+kooXnTHTcPwtoDyU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dqCnAh1BbLC4UUZqacrs2RhKEUbD1BMQI787FnPh0381EMB0HKLqo/8ChzOndcjFF
	 Ff7f6DQ79rxj/usVfMc3B0mk0FHLqezX4AW8zcALNEN2n5Gaj6clKYcoFkR21J+vhk
	 +PH6O+XX5Wp5CP+pbN+sqgVYSJtPWGmKC26Ecu2dE/QTZimw3AdYNVNBhGyfS1qfZE
	 QYxDkG4Ey+vMUYe24LNge+fRZ/QyuOuPlMmeEibZgdrq91HigjePWCflbW6LCU/7vJ
	 Eq3ehcZsTsF0EUMZ2cxGxWKOwXD7b6N1Y0X9FZEwQ4E2df02Z8zx8lkjbVkCAO0jc9
	 rQY8thg16H7QQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A812215C026D; Thu, 09 May 2024 10:51:24 -0400 (EDT)
Date: Thu, 9 May 2024 10:51:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Cc: stable@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michail Ivanov <iwanov-23@bk.ru>,
        Pavel Koshutin <koshutin.pavel@yandex.ru>,
        lvc-project@linuxtesting.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Artem Sadovnikov <ancowi69@gmail.com>
Subject: Re: [PATCH v2] ext4: fix i_data_sem unlock order in
 ext4_ind_migrate()
Message-ID: <20240509145124.GH3620298@mit.edu>
References: <20240405210803.9152-1-mish.uxin2012@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405210803.9152-1-mish.uxin2012@yandex.ru>

On Sat, Apr 06, 2024 at 12:08:03AM +0300, Mikhail Ukhin wrote:
> Fuzzing reports a possible deadlock in jbd2_log_wait_commit.
> 
> The problem occurs in ext4_ind_migrate due to an incorrect order of
> unlocking of the journal and write semaphores - the order of unlocking
> must be the reverse of the order of locking.
> 
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
> Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>

Thanks.  This has been addressed by commit 00d873c17e29 ("ext4: avoid
deadlock in fs reclaim with page writeback"), with the same code
change.

						- Ted

