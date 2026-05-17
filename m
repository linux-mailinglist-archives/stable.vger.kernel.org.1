Return-Path: <stable+bounces-249137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNfyHCUFCmqNwAQAu9opvQ
	(envelope-from <stable+bounces-249137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:12:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B22562EEC
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47580300BD82
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38B23C65E0;
	Sun, 17 May 2026 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsZ3jaqK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455D285050
	for <stable@vger.kernel.org>; Sun, 17 May 2026 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041336; cv=none; b=TCQRF3yqSGZyoGrcvjMikjzdHVyz1yJXdNJF70MXeEYe7Vb56Fu+ANoDujsM182xQ7HfERhgL9Rg+UMVjpohLkssmjYgyqLLpX1JMmDNhBNDO6hdKMABNuaMexpGJ81bIKdTy3e2Mr1Iq1fsGZ/VIOO42rqUJw04kfLtGMst7UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041336; c=relaxed/simple;
	bh=rOgPvVJ9luMy3zvxNUEgiV+7mlyNFSeV5ChMY+xLhFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFRSDO8SoCRx/JvQp98Xkj5MkVg+WDOm5L8xXsX0XqHrLPRtMZliV5BtARgt9vLkjpghid+z/W7eGzAFoyf79xbGJ5uVY7LupxA8YTFEWRNWiG9npXc2FTMiMP6PYq5CtSInT1c70rc5Ih+m0fryADyz1H0EAA4N7C2Te+GIlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsZ3jaqK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso11647675e9.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779041334; x=1779646134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOgPvVJ9luMy3zvxNUEgiV+7mlyNFSeV5ChMY+xLhFg=;
        b=ZsZ3jaqKiaMrA38mhvlb8vku3Jq0uuBD+gtuBnO/f+J+d91trvIlRHRXVYDN7NQWKR
         PUTDQ/IrWbIK76x68eNQ/dozGSFVCwkHhoJnvwjAA59XVEXIQh1u6lxCF5BJtR445wfp
         c1z6z38STj/er0/mx7/S4bioyJn8gFWGRn8ED+6yC9ZWF2ANigMbTeOHBdCSMjeYwJ7S
         xcMxVBXDYDPQJBsKHzea18sQcJFqacJXn2od1od9Gb1bEymFt6jTLoRiW09jTkBMgKYI
         PVd9vDc3R9/XLDpEmTjLcEBUwiAIxEtS3GiufDwdnhZAnCwpr9l6K6ml8MJbCXCt/ISX
         g72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041334; x=1779646134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOgPvVJ9luMy3zvxNUEgiV+7mlyNFSeV5ChMY+xLhFg=;
        b=Yw3469D6fh6Z/venmDB37UhO6cG/V7RidUSlT3BXPTmxhBwxeWUEtzeKhRp/5hJHpM
         ncYhN+byM1/nhqQZbVEcPDPOIB46A9kon0sD8ulwQHcV8lnodIlxemjW+fa1tGiRHCqJ
         E6T7wW1yc4rX+vzuwWLDQ2QNCq9tekKA08NyPpsy14v8lGo8oiClMN0reCntJrXG7kJS
         ZOcVqcf1ARQhuHRXnmTwe/8edsMgiiZAXO8Sq4DVgUAryecA95Cok1mLzNhJEeJjkLLN
         v17wGEaJrIQS2l7CB6X+0793YRRASqYtRZ0jyD2rOR7yGYBFKDnGweG2gV7UbPAt6P+w
         l2Kw==
X-Forwarded-Encrypted: i=1; AFNElJ+knsyqTPCv7lS0BbXRuclyN5/4lLfmAzZGPyaPsapP1jQaQy+4PfHddMfjPYX9H7LhlLavYSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDxZSXIUvWzNqSOUI6D/t+e+vLr7V+prGeZs0jhgcV0Kgw/9m
	gLyzeaQD0jUb58CazUimP/mYwlSNXHR9Df2t4+KcWyzAciG8FrYeGVBU
X-Gm-Gg: Acq92OFKLTimBLwwE9gMWsux+XOB97nAKOFcgessIKG00fN0jqN8dbnL+WI29oVAOKc
	ZKNb6BoR/7evbDyjT7z+D4mjICMg5WMvgKfhVBrQJ13vo3++lOkDzRvynnTfJzDiHRfGJct6SFN
	F8tiG3Yok4W3d0XFTHzhiiXewvuB4DMO11Nv51+ub4gzxHS3oZx7VALYsqUbYdykzM5xfX5V8/S
	th1DJei3yPXK/WpHJy+6iymnNzN76OqyfXqRrh3i8fisSvq/UdZ24gsb080uNSzftYWonBejxtj
	h+7sCHQV1MLN1vyFKO+4ZCeB3yJjZMuc70W/Is6fXiH9QxYL3RWv9ep6shscsvYp3lRkFJ/Suf6
	IUITjGF9ie6utBuB6lUOV2iYz7/vRGTDCYU3yy6bQNjqyoLcIqyjb9BzLU4RZP4BFP3CTAVo6kR
	QzlZI+gNY12LiEVPidkIbnhIwxCmggJOZDJEotM8S/Vjo1nbp0pxNP/NRTFV3zKa76jOhQ13Sy0
	Q==
X-Received: by 2002:a05:600c:3b12:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-48fe61ed2cfmr169618865e9.22.1779041333535;
        Sun, 17 May 2026 11:08:53 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe585absm65005075e9.19.2026.05.17.11.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:08:52 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: pmenzel@molgen.mpg.de
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: SMP: add missing skb len check in smp_cmd_keypress_notify
Date: Sun, 17 May 2026 14:08:32 -0400
Message-ID: <20260517180832.52329-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <3a7eaf6e-6e4e-42b1-a136-3ed2befa90e2@molgen.mpg.de>
References: <20260517145417.31910-1-meatuni001@gmail.com> <3a7eaf6e-6e4e-42b1-a136-3ed2befa90e2@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 06B22562EEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249137-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Paul,

Thanks for the review.

Moving the check after bt_dev_dbg() would not be safe since the debug
statement reads kp->value, which is exactly what the length check is guarding.

On a truncated SMP_CMD_KEYPRESS_NOTIFY packet, skb->len may be smaller
than sizeof(*kp) when entering the handler, so evaluating kp->value in
the debug log would already access out-of-bounds memory before the
guard is reached.

Therefore the length check needs to remain before any access to
kp->value.

Regards,
Muhammad Bilal

