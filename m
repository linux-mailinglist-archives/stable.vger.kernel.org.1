Return-Path: <stable+bounces-235324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAgaKalP12mvMQgAu9opvQ
	(envelope-from <stable+bounces-235324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:05:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DDD3C6D19
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4C03301904F
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B32034D3BF;
	Thu,  9 Apr 2026 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GtsogTdI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46233F591
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775718305; cv=none; b=tLdsGRqpZPGnwI29Y0FE+Gij7zUSdwF55hSA16zoe8z1nOFrUnya/x0Gq7hoz4lUA/tR6BCTOB0DhG70wiFSlm4X1mfGuFpF5ummy67sSgdf0kQTSFoO+kfNmIh4kEUOY2hWKc06atzNbm52wVb4InPvt2TXQ/upu3vvg7tRcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775718305; c=relaxed/simple;
	bh=H0aYsToETw7Hr4e3qPR/cze0zmiz+Q5WCt4WYbJ6rT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOqLSxLLnErkhdYRoIO6uViSRNEGTa+pbTTcoiF82nkCcVZ9DZ9rQDVP1QsiRDDRyEapk3jawJp2opPy1f/QdLVU4GoF8V2LSpu6aiJkc9XNHLuOhjIbn6mxzHBCBuJZzEb1mKu3ZlBgbsDgS89p3iQ6eegy+URqG6mwqpqdV7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GtsogTdI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so756063a12.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 00:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775718302; x=1776323102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1r08P1mrCxaZyY2MEWPUoMrIusaB3cSJKW/lSXpSJUM=;
        b=GtsogTdICkTN59VyKm8kZXLCYyvvb3+C07YGbc14HavToFuqewZRZ8agkxdenS+Jvf
         hY2GQJnusLeMgGt+qJLGU46k7kisZ17Q6k/0NmMFmqOgdQdPVHP9bkhf85LYVghZkqcX
         E67kozWL1DfxWD+efS+ZG2vaUaiV4lRNBcAaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775718302; x=1776323102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r08P1mrCxaZyY2MEWPUoMrIusaB3cSJKW/lSXpSJUM=;
        b=hld8N1rZ88LeIxjCa3xaNrDPSaYOAWMUrsHmN27HuhyXTBFgZCX1Xy5sJfDaAQvAv9
         boxtiWi2Z/xzsQSFLKrEjI0yDbItFqeZw4KUuIaUH8hxP61qc1Lm/t3PG9GGUYUIccP/
         mCpMYh40cH46yJgjEI9R+ms0kQzYkFFCnq/1C6uAOozZIRUXLNIAlbr0sj3XbUkCn3oZ
         eVGokWJNmuv4Q/okDfRq51ePnCNbCe1LVcnNAm5xxJCBl8TzbhoGz5EMeRE2No8BGPzn
         wS8g6PSTY9uuUB+D7aL6iHQwGfgiq7G3nG5ZePQZkejVcqG5JxwNDuwCibPLV+xduB1b
         C/eg==
X-Forwarded-Encrypted: i=1; AJvYcCXCSwHjYoW10s6mqRqF46sccYzX9o+KnkJ6g8OeS5SSjm9wpACc8y2MesqEyuWEZ4q/wDKTLEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0+RoxDrzBOH48ZCxew6En2DHhvU+tdLyk8THdlTx9NqthTcG
	XDFaFTtl87ptF5LT+GvybSt0Djr2sfj9fq7IHR3Tn2qrK/P6/dnMJjLWJ9E+tgiruJs9rgpN/B7
	Z7iNDrw==
X-Gm-Gg: AeBDieuqr7GRScsDN2lUOwsbYCCK3Cu5O4yrgoJG6cB7FIV+mbaTXZSMl+fiFAyCLuZ
	tWQYHfckhjajaD8Ml79GyihkkeurbotrNVMCbYD3Thuvt3Kjibm+ennZT+ol16ZNVRt+CMbW+c8
	bVW4XGrRBWfS9rABZPy7ByaLDFfmX2NNV3okegLASsSpJChlXfzfPBCwuq1/ch+G7MIvvnt9ZK7
	6Sfs966mBrDntSUDrSJ7Kyuz6T9SwjpyKZrZPv0UAX+69IWZxNM43IClJeePrY2XmM2hwmNHrX5
	EVXQAbnoUvGAH47TyI+BsMuKp4dF3UUa2iemb0NfiW3DtwlxUoGaXjRELJUjsRMgrarVQOWBjbx
	sst/1IFA9m5kd0ze1pvJX/ZznC1Us0EuayjE8C1fS0sQ01dnPKtgBZN9EbwAJHolej1OFZ0Jbx/
	LUc9eSuOY1uceubafcfLytD5MgAJ5ErQ0bs9u1kPym9G0druamefKD3yZ9SovLvY2gzi2ZV9k=
X-Received: by 2002:a05:6402:3554:b0:66e:6f1d:6d67 with SMTP id 4fb4d7f45d1cf-66e6f1d6f67mr9659333a12.8.1775718301781;
        Thu, 09 Apr 2026 00:05:01 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e033a787fsm5590815a12.14.2026.04.09.00.05.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 00:05:00 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b982b0889d8so69880966b.2
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 00:05:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWg0bP/nXSzf26i925SGxc3f/n3CskiJ0Isvmvu9qB/FiXiaGXllBJnZGdnFSDDLNkpvyRh/ZI=@vger.kernel.org
X-Received: by 2002:a17:907:6d0c:b0:b9c:94a3:317d with SMTP id
 a640c23a62f3a-b9c94a3345fmr1003075866b.37.1775718299119; Thu, 09 Apr 2026
 00:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401081048.2338697-1-johnny_haocn@sina.com> <ac0Ww-aoBRmDkSE5@quatroqueijos.cascardo.eti.br>
In-Reply-To: <ac0Ww-aoBRmDkSE5@quatroqueijos.cascardo.eti.br>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 9 Apr 2026 09:04:46 +0200
X-Gmail-Original-Message-ID: <CANiDSCukK5wBm+kO9hcYho+j73Ko=17D975bwd8iT_NC4gkEaw@mail.gmail.com>
X-Gm-Features: AQROBzB5n7Q-QZkSmgMLVekEJdevS2ioVD0OlpeizNKl_o3jvmUo3i8vjxx-aB8
Message-ID: <CANiDSCukK5wBm+kO9hcYho+j73Ko=17D975bwd8iT_NC4gkEaw@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>
Cc: Johnny Hao <johnny_haocn@sina.com>, gregkh@linuxfoundation.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+0584f746fde3d52b4675@syzkaller.appspotmail.com, 
	syzbot+dd320d114deb3f5bb79b@syzkaller.appspotmail.com, 
	Youngjun Lee <yjjuny.lee@samsung.com>, Hans Verkuil <hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sina.com,linuxfoundation.org,vger.kernel.org,syzkaller.appspotmail.com,samsung.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	TAGGED_FROM(0.00)[bounces-235324-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,0584f746fde3d52b4675,dd320d114deb3f5bb79b,cisco];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email,mail.gmail.com:mid,chromium.org:dkim]
X-Rspamd-Queue-Id: 09DDD3C6D19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 1 Apr 2026 at 15:00, Thadeu Lima de Souza Cascardo
<cascardo@igalia.com> wrote:
>
> What about the followup fix 758dbc756aad ("media: uvcvideo: Use heuristic
> to find stream entity")?

That does not sound right, the following patches should be backported
to all the kernel versions

758dbc756aad ("media: uvcvideo: Use heuristic to find stream entity")
0e2ee70291e6 ("media: uvcvideo: Mark invalid entities with id
UVC_INVALID_ENTITY_ID")

Regards!

>
> And what about 6.1? I don't see this at 6.1 yet.
>
> Thanks.
> Cascardo.



-- 
Ricardo Ribalda

