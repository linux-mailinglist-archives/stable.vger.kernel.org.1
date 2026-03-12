Return-Path: <stable+bounces-224783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDaHA54gsmnlIwAAu9opvQ
	(envelope-from <stable+bounces-224783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:10:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C7426C198
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B0243035030
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E1F2D77F7;
	Thu, 12 Mar 2026 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp8i8SMR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A10375F9D
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773281431; cv=pass; b=kF+v2aMAmGzlyseRizXmNJDctLBt5C8dxMoQbFpYIe80Hdvr5J4SXkj4t+2Prkw7r6B26GNY63dmHkm49qoxYFRdOQxiiWoHMq/HcHeg2vn3mCKoV0gP0JXr8/Y+17UiEZ89HH6NUjOYv/ULKmoMbOh0hLW4VscO3JZ0AQ0HSf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773281431; c=relaxed/simple;
	bh=uAOVhNzDH+nb9Kc/yjaQMWFh3tidbWM9bwHFzGealYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yr4T/ZIG6Q7UGSWK4ePV8tW1ohGoP9JplvAsZUABpnFtES/H9TcnDVKrg/BuK4VMUaJNtewZDJ1NjshaDapnPfoYlnQdLED8qX3M/mnv56D8NvpH+qpi/RprYvmzq+9YLi7eGY18Pwzl7P6Kvv9UuIDUTQ7PxmABwnHsFBvjT8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp8i8SMR; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so669287a12.0
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 19:10:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773281428; cv=none;
        d=google.com; s=arc-20240605;
        b=iyNMeziz2A7CcjO5sRJhd66OUq0w4gpFjS2Rdb9PsuauxHVYmMFBFii09TKW7Tbh5J
         fqr/rmDQvyHmIFE7mdPzDIVu+w4kZ5abN9Fbmud52ob66x/ZeM30rtG0NOFsBjEpKXfe
         YiWqIUNE9twhWq97RyV1HeaZ5rt3mT8H5opO3hAcDXu4tfZL6rfqsSV6nuGs51uBlN75
         ENRLjeQCMXxOcUAzLZktbJCziM9lW3wNasIQrcmNAvVBE3c34E6hhYCpsJCq7QcFnLLO
         CmjStrWPqO7gm9aomtuUwEORzZhjdLYhK4Am77BLJFFDtASQWcw2ZKYlu8MlnF/22tEM
         S8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uAOVhNzDH+nb9Kc/yjaQMWFh3tidbWM9bwHFzGealYc=;
        fh=Us0sIi/LzU6zdghLeoBZNlDwIIg5dMFxDczzME7gY0o=;
        b=Zjh5/tghQxAC9xPD/crrmZ8tmBp8C5YB7/pFPBVTXgtaWs56g81cuBAM4Ymhb6gVuQ
         z03ytFu+grQXEkOfo2V5S0Z5U8WhU7FBqA4aLo+uZBETcdgXeRPjNhALIm/73MqagE4x
         mt6su0Bsj7E7x3wZ7ISe/Lu7hzy8gS6bTX5jSU6iODlz4g7siQK+xqpr7S7rladsf2Ln
         8T94vDx9n5mIsgdJIQtlMIbOaBfYVmXm/vQrXJ1Jnb98lyD+Z+9kZUXo4YBrWy/X+LKe
         JKRPKCQhk/n/gmD+LYeucVD03uzg/4nooPOfuODWh/KGGQDawjOyI4CdivDv3cykWc88
         COnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773281428; x=1773886228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uAOVhNzDH+nb9Kc/yjaQMWFh3tidbWM9bwHFzGealYc=;
        b=Gp8i8SMRZw9FoG1vD1GrOSgTk5O7zLDohdEWX5eXkwLNaP/mOWzvXc82ESPFZw6BBu
         D69GiKN4ttLAEvfzFXovQJPRsbKiWhVXZ3YVG+NFbpX8zCwpUzbkshl9ZKQO4hu41+L+
         aRToEmQjZE9WUtpzGuKnkQHBd2FpI0w4U56E1nV6zG6Euu+O4hiRZ8rBWhKeT712rsy+
         1v+ovCuUWalBtYEToK8RJ1HiIMRp00V6w1VZUOI6Q/GxMfufJWvMUHrO/8RlHBQX24Iy
         qmZCLBPUZzt5DIMGDeXlYKDQDXcyT+ARykoy4o8mnueANO81EFrxKtS5BPQUBSzSJkDq
         vs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773281428; x=1773886228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAOVhNzDH+nb9Kc/yjaQMWFh3tidbWM9bwHFzGealYc=;
        b=a6/4lYAIBMgCJDF6RlHbkWKI6RHe8bHcqEuoTlrzP2BYwI96WxQBr5KDFDijEvROc6
         lEdzbVwicoAbWTV7kumMkEfICo7zY214bTPU1cU8/DYaRxgFDPVrP069mii4QX6MQbhq
         o9/wFOt6wKD7uW6ym9gHF8rH8QrK3iyxK5ymJAGvulAUDw7l8cCiPxkhQnRaG1AoQnve
         FEjQfjlv6/p1h5ZAvP3UGKV7L0eDG6Lpk/Cj1UBdOj2YQikGQRC5U4eoSZ70RiupSYKW
         d06J1E08Vy64RtW47EX747HHOaSVBRYb3bY8qQQ75yFI05NNkUe2qc3Nm8TY9wuxb+Kn
         5uug==
X-Forwarded-Encrypted: i=1; AJvYcCXM/dJDHOCy71Rqef0PHoasJK98xoqPiX3oj1GcXTqBABhnhxE0wF+sr+9q3icXTgTVbtHKyH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0NPlGdUsTjrnauLx3kFZmFubMNwFlJFN6d+I4AX4yuoTNJVno
	jmujL1IpooqGHG2T4HR+xeZe6jFwcEvxHq2M0+Opu5IRjb7M+2A5L3q+Hhkdw+/KhYCaXkba+UU
	yCbPBRFDJLblV0Uevm0piGP8Ui0RbxBs=
X-Gm-Gg: ATEYQzyvdR4zgeglgaDUktpOsNeQoomtio9TrHxfjuvs4fqwoWQERcItf7BQmr8I4FE
	86xjtB2BbwTIHNCKAuSGxhevZzzKTBWrorynUH/QOX24ok7omk/X7c44ZlKA25vGBQp3NuEJ+Pf
	Tg3CJAD1coTS1mh7V6oiqEHSKUeCF2vgZCMLETMR5HBmT67naZXE/SZriB0CQkjk/iLMruHUmXY
	G3UDe1+yQKegDsw5D90oUjAcrcqTRTNtFvjm8RUH+aBhSbJ3FrDHM65H7i5UHpKKMNvM1UyLdiK
	NW3ROdH7XGtMq8fyLOMm6c/NQZAOrfIZyD3iaT6tYYmJndtrgJ/iWQE=
X-Received: by 2002:a17:907:e112:b0:b93:8e7f:3d3f with SMTP id
 a640c23a62f3a-b972e5faca6mr189113066b.32.1773281428332; Wed, 11 Mar 2026
 19:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312001443.3011961-1-gality369@gmail.com> <17c102a6-bbd1-4937-b5cc-5f6912551180@suse.com>
 <8533b404-3377-416e-81d9-2bdb00baaae2@suse.com>
In-Reply-To: <8533b404-3377-416e-81d9-2bdb00baaae2@suse.com>
From: ZhengYuan Huang <gality369@gmail.com>
Date: Thu, 12 Mar 2026 10:10:16 +0800
X-Gm-Features: AaiRm53d7xqK8oTpL1WJOX5npfX4-cLTkfjwSrYGYK7OxzBZYQaiYslkFoedJ14
Message-ID: <CAOmEq9UusAbrMLSMkca+DEPff9hXokAvVn3V4acQ0EvSp67HLQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: reject root items with drop_progress and zero drop_level
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.com, clm@fb.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com, 
	zzzccc427@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224783-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,fb.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 84C7426C198
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks a lot for the explanation. I think I now understand the
intended use of the
Fixes: tag.

I still have one question, though. In this case, scripts/checkpatch.pl
warns that a
Fixes: tag should be added, which seems inconsistent with the submission
guidelines you pointed me to.

My understanding had been that patches should generally be sent only
after passing
checkpatch.pl cleanly, so I wanted to ask: is this kind of warning acceptable in
practice, or does it mean my local checkpatch.pl is outdated? If it is outdated,
should I generally use the latest checkpatch.pl when checking patches
before submission?

Thanks again,
ZhengYuan Huang

