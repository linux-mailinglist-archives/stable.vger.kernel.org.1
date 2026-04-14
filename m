Return-Path: <stable+bounces-237729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EghKE/d3WlwkQkAu9opvQ
	(envelope-from <stable+bounces-237729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:23:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFF93F5E87
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A523043D05
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 06:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDD533EB1B;
	Tue, 14 Apr 2026 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvuX0ikd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58950345CAB
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776147769; cv=none; b=hElyJk5rQGCnyPE3K9LHgiNf5UrZBjJlT2e+WumKBEj8riwYm5fsq3Lbz0+ven5DEsCHK1LQ7iFtmGQsqHVr9jZzlLsWXsGmFlyggxK6khTZb8ZqD9GOk6w/mL5WTNrxMp9MnmHaYKYR2LfYa//ttPdlNHPG9+S85GFeRgpwlHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776147769; c=relaxed/simple;
	bh=nKm0GbVKCHtHP0hrVGkVDigPvP6pst7c01jVOvopZME=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=al++lvWUOeijMuqTw6p0ixjR7Mk86ljyoT3LoG6RMRRNN7j9cFCdA/dz1BIgTb6L/BfRge6CgPetKbjTCV4FSDII6SAVq13cdTstvFfz/nX1Oi7+gTVhZrt7aEPlkZLhAdjjp5tKQvEcPEiUlNylXcwP4dHwsoH5p/CIV2aL8yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvuX0ikd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-671dad7cac8so648359a12.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 23:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776147764; x=1776752564; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i7FXQ2tntyeG1C8OQfk9LnQuBp6YLBRP1mkqDhPOgr4=;
        b=jvuX0ikdIcfAJ8/iWbp9DgtWA2eBYzefwuygte4IUUz68hKbynEzX6357Y6U0QJAJ9
         Zu7UKzSBDaMj2BW9M0pqOeH7MktNq6XsMMc3kb8nMJdjVHylP1846mUUtcmgl9StC7Y2
         VvqWWddvUBYu4GQr6sxAm1MIF0XisHb+nWFjETnXJRlEAFVr1EXlN0vQt9KSlIXmHpRP
         cthA6I2zYi8wkCuK0hK+acvFf5u+mZssriTKlCwHnt6rGJ1JnD8xFMUllBvDjohbDJKY
         jAYrX8sotrAI4Ew0C2Chn2wpmzesWGUu5cWygiMG0w0+C9hAY6IoBsB7cHIXexd3adgg
         UteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776147764; x=1776752564;
        h=references:in-reply-to:subject:cc:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7FXQ2tntyeG1C8OQfk9LnQuBp6YLBRP1mkqDhPOgr4=;
        b=WaAYaAaNCf/TN7frfO/rzQvSnc+HFym5e6Owdiwbky1AFD9DDO3wevuYTtNs5AGlhh
         9n9hVea9ibPqGW2U849mQen0qt4GwMy/hcfew/by4Ydhv1sBPEmU8aBOpu3LTBvSy9tz
         xEJEEsKfGdd0+6k48ywDueq64UBlstfTZhVVQpGPDOteBj0Axuuf5QeHh/1yFpg+xlc2
         mKNFc0UjePu3AwFTMS7zQv2RDQi9yQhVo9Tl0Cu0o8DonouSLK0cy5V6Ittp1gFiBe7D
         GbLtkPSdY9KY1cqQRmVdoNG5oa+x5EpA9FmXZX59GY/161jQLhxbAlzQG35au3MbGqgw
         0BjA==
X-Forwarded-Encrypted: i=1; AFNElJ8lc7/eusn4u+T2MtUFnGm+1b/DvdmSM1mbKvJO1ONgBmsL6Ls+SwLDCOJH5Rhi4RTpfRCXGmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/MQqUc7f1irqC+ZZcRCkV7YG44J1ChG+pNLFqGLZS2ysPmNQq
	F/r5epGP6YdbqI41f61Bg/FaAWet7PbQ2rhhnuNXfVZPSr/V+gGXcWHS
X-Gm-Gg: AeBDietyDfcfF3FHsM3VU+dAdvJBBbaEzFh41ttIcvAz+rbWF1EKXy/85rWCh6PFEk0
	B5sdEHCQwTfGYF/oiN20Aj5YgtsGXD6dhsNkiqyzi+UfRedaJ8zxyBxjwigmVJOyBdTktZbhGK9
	Uyohev2ho8ysBKEFWw7+0fShLABNCILjDYnQR94Kq4MzRBcGhLzcjijDlsYWAmuzxxbAfeJQAOu
	f15syPcjf7rEErRHCIUo4uNU/amKzLW1AD68pVW+AkIjdNWDPV+GEcIai6PIq91Vvm9VndIT5sM
	/pi21SnL6Kv5FZd1rZoys2OJkvbroj/ruyvJE04O8w3a1PNqV2otWxwbV9RXAmjJiAQGxcLtUJj
	mM2LiHgsyLke4HiIvjo3PJuZdpCkdfbUn28PByFZym+UkkqD6jlCj375K7mzM0SPGw64WHdcsw5
	yI6y/xacnZchYKyzwpCM+4k6YNN850MoWPs6wRTTYZccf0wjPulJJWxz4zvqEVbDIc+ckHfG3Ig
	wVbdAP3GU5wt35LcdovVTUPz4rDiW0Z4pS3ium+w5q68XSFYTJNL1IiRjh8cw==
X-Received: by 2002:a17:907:c20:b0:b9c:b7c7:8a7f with SMTP id a640c23a62f3a-b9d7249947emr910336566b.1.1776147763849;
        Mon, 13 Apr 2026 23:22:43 -0700 (PDT)
Received: from ahossu.localdomain ([88.202.160.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c582fsm385453366b.31.2026.04.13.23.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 23:22:43 -0700 (PDT)
Message-ID: <69dddd33.170a0220.e92ec.d295@mx.google.com>
Date: Mon, 13 Apr 2026 23:22:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3219866366644994571=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: dan.carpenter@linaro.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, hansg@kernel.org, stable@vger.kernel.org, hossu.alexandru@gmail.com
Subject: Re: [PATCH] staging: rtl8723bs: fix heap overflow in OnAuthClient shared key path
In-Reply-To: <20260413202824.740653-1-hossu.alexandru@gmail.com>
References: <20260413202824.740653-1-hossu.alexandru@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linuxfoundation.org,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-237729-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DFF93F5E87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============3219866366644994571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, Apr 14, 2026 at 08:19:00AM +0000, Dan Carpenter wrote:
> Looks good.
>
> Reviewed-by: Dan Carpenter <error27@gmail.com>
>
>                        p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&len,
>                                       ^^^^^^
> Do we know that pframe has enough data?
>
> KTODO: check if pframe is large enough in OnAuthClient()

Good catch. There's no minimum length check before the subtraction,
so a frame shorter than WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_ (30 bytes)
would cause pkt_len to underflow since it's unsigned. I'll send a
follow-up patch adding the check.

Thanks for the review.

Alexandru

--===============3219866366644994571==--

