Return-Path: <stable+bounces-217642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6X8kIbjqmWl6XQMAu9opvQ
	(envelope-from <stable+bounces-217642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 18:26:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D769416D612
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 18:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7404301D6B2
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 17:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F382C21F4;
	Sat, 21 Feb 2026 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Mj4+zzcc"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7E274FE8;
	Sat, 21 Feb 2026 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771694771; cv=none; b=nuc52Yh31MSkAVtRTMzRPpSS5WWUnRv1vgh2T/sKGNvq464xMo5Thwo9J+215jkKq5YPSgpzHaHl44o3zJgDfLYFzIgPWZCX2e+SJa1Vkb2Tmd7+WeGOeGMwkOTMSqqACyckxI34/jCsGCkHjXxTF4mYL54po4cIh0WPIUvCOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771694771; c=relaxed/simple;
	bh=Iu82OwNmD/WjOmbmiKkgl9J/vfwmNZkXP5G18ox2JH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2a9qIR9vpY0XFmJGOlLFzHZFSiKRnQQlDkp2I8XK9RWAmfK34//jIhw69tngBcaITbGFi1gMkHFfksutkPUgGEnCvBFJZysOAafmjmSYr4cf69o2eHTrSnegLwaSfWlYYpPlTNK3cwWfEG4gS8/tcoynjIJt0KUkDM0gGNLV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Mj4+zzcc; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1771694768; x=1772299568; i=deller@gmx.de;
	bh=lbecuum07+7hKXfXBYCZSDCRYQFiQ6CS2YgLjZsf6BI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Mj4+zzcc9sGN9O6ZvOvyArJuuGApLSqDgLxJ6uNrqzXOwG0lkayUtJ+D6pX9glvd
	 39+oMOxAW2B8KppYg2pCb1AhHOS87YWUQZKYIuWeCga3oDFQONMNlHjipusc/WVHr
	 C99r7DCz8d7+SQcTpxgOKxTqZXkNAqdgY1KsrITRq9tOEDnZRYlG5EosEr8C8Qi82
	 bc1ZSFUboCtvEGtua6po5Ay+tHpXw1RdyGhIBYARj47jCypvVZzgLIENG5GbjG8ki
	 ocAOI7e/OK7QFPKGsOhi5GXBLauASfhm7ISAoCVT5uJXlskBMuK7tGdvJ2e+qVyuN
	 mVaWREfHFmkSjveuJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.28.88] ([109.90.133.241]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1vWHe90Ae5-0101eh; Sat, 21
 Feb 2026 18:26:08 +0100
Message-ID: <610d6de1-e5ec-40a3-b1b9-bad3bc76ed12@gmx.de>
Date: Sat, 21 Feb 2026 18:26:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "fbcon: Rename struct fbcon_ops to struct fbcon_par" has
 been added to the 6.18-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>, tzimmermann@suse.de
References: <20260221162238.4086398-1-sashal@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260221162238.4086398-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XvfV0iLqCMWerWNrPS091ShQqmorPIKNCZ/GUMB09Kr1Rc/KH/6
 Ht8xJQI05gKTCk+xBbV0I3S4zHSTFCvypj6tqGeDYVzcgU2YwrTUUdZSWhUvatFpD0FprW6
 CMgmjKKeoxj+XPDKABI7aHhJE4U0M1ZSCTlHHNBSNfB4Mt58gDxRHR8sMUlrxSsTtFmBUUv
 qkQZMwjnJid+Z2VjMYIvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QJoDPYSMNp8=;vZZX2R8Eyxf4NVIbBFI0eQK70K6
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217642-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deller@gmx.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:mid,gmx.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D769416D612
X-Rspamd-Action: no action

Hi Sasha,

On 2/21/26 17:22, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>      fbcon: Rename struct fbcon_ops to struct fbcon_par
>=20
> to the 6.18-stable tree which can be found at:
>      http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue=
.git;a=3Dsummary
>=20
> The filename of the patch is:
>       fbcon-rename-struct-fbcon_ops-to-struct-fbcon_par.patch
> and it can be found in the queue-6.18 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
I don't think we should backport any of the "fbcon:" patches...

Helge

