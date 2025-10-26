Return-Path: <stable+bounces-189758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D05C0A486
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 09:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86C084E7311
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 08:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6711C283FE5;
	Sun, 26 Oct 2025 08:12:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7F280329
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761466375; cv=none; b=ZW0SqchBn59de3kZfuL3+OO/0wH9eolzhqfJ6Q43eeFr4pJvi3W1LmJp0oyLK2EwRIE/cgKGfL54ZHsaP8ANtjvspoKbkyDdxBnWNodiGwdxo3ngB4XobqvxCBG25EYVQB5vsdIb+smAAKOoYvwNUOATK02X4ecdXE2aMbVsL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761466375; c=relaxed/simple;
	bh=rqdNEMsMhFsdzIj4jlmk14eVtdhgCbjIL4gLgvIJA1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EY/9P1w4ASA/gSoPc8/3lBWMYNr7oLtXosb8CVsAqistgY72L5T6L3nlyjRTQuCD27y3CRUiQ8XRfQR0ekGzfybmqpkrqaWduteAPnfrMVyiWLH15drbawidB8Kg7MvyG4jQ2gyhvGSULtxOeEI7Pp92vy/hxdmNZihqfuRoPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59Q8COLX072897;
	Sun, 26 Oct 2025 17:12:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59Q8COq9072892
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 26 Oct 2025 17:12:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cde69513-a413-447e-8cb4-5627da29550e@I-love.SAKURA.ne.jp>
Date: Sun, 26 Oct 2025 17:12:23 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.17-5.15] ntfs3: pretend $Extend records as
 regular files
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
        stable@vger.kernel.org
Cc: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
References: <20251025160905.3857885-1-sashal@kernel.org>
 <20251025160905.3857885-125-sashal@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20251025160905.3857885-125-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav204.rs.sakura.ne.jp

On 2025/10/26 0:55, Sasha Levin wrote:
> Conclusion: This is a targeted bugfix to comply with VFS invariants and
> prevent failures when interacting with $Extend records. It’s safe and
> appropriate to backport to stable kernels that include ntfs3 and the
> may_open() invariant check.

Please consider waiting for
https://lkml.kernel.org/r/tencent_F24B651BC22523BA92BB5A337D9E2A1B5F08@qq.com
to arrive at linux.git before backporting "ntfs3: pretend $Extend records
as regular files".


