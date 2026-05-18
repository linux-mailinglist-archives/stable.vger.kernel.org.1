Return-Path: <stable+bounces-249230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJdtOxzTCmpK8gQAu9opvQ
	(envelope-from <stable+bounces-249230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:51:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6EF5692C1
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C76C30062D1
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610B43DE453;
	Mon, 18 May 2026 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjR9+Gme"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20730CDA2
	for <stable@vger.kernel.org>; Mon, 18 May 2026 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094298; cv=none; b=BObcaPxDhGWHSvl9ocvfRQ4zhnxyk1liCMUMXDxEZj3wFGSqODfGmub7r96hjZuqy4H00Kzq9dHlVyFupZ8q4MG+bWm10vodhNkABjFDMue/lh54rwHz/EDfDHw5G2mztK5chJV5EYnBdE/zF7IyQ6yHS0zq4ACBTLOkLS+Wgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094298; c=relaxed/simple;
	bh=j1+uxRafIxzC+p3sbtdhHLulkjt3LXF/dmHS/Cb6Hl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IlKiMKZZ2t3AObb187tcCBkWSeC9SeJYmGHlnGbWYAOyMyb8Y+UEjVE+qOtkO8ColGCd3TeLlWccb+ouOplPeHEFshBpUnm8PwR2wg0/FWsI9QSQktVamXjgyZgA5R2va//1e11GqPYDjiWpcmP/3NdWoMNE59lstl7O6lWGC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjR9+Gme; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45e5f81074aso72896f8f.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 01:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779094295; x=1779699095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1+uxRafIxzC+p3sbtdhHLulkjt3LXF/dmHS/Cb6Hl8=;
        b=sjR9+GmemyZ5Al0zRoodyvNv5cjoJiwl82Mt9uAI2MsNwZMBBkmtRAqlQXsWE7naQr
         zdJ0BXwtFoa0Dk/QEb8birASP/ZT1mhCONG6NgND+s5iGCBkmOof9O+UshW+er2EQEI5
         fCqOeaITh9IGZd2cyuWl0nbNVtCkFL+OQSYrqoCBHOjUkB+jyufR8g+PFQXeiTp8M10c
         NozBl+TP9JTZJKZRAFG+blL29l6samOBs7NnxaCA/0GhGHjLaamEUzjAgpgqlqGFRP7I
         jluZyANSSGEUv2vJf5TJjDccxp5qgq+BS7Q8OUAgVBoK/uQkoOhZGn2/6hJ01JPQjgZJ
         j14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779094295; x=1779699095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j1+uxRafIxzC+p3sbtdhHLulkjt3LXF/dmHS/Cb6Hl8=;
        b=hOxQNbWX3ZuKG1VEpI0tiXASs7S+joIyAgdQPeEXpH50yDAvTY2TBg/Tu+G+YLd2I3
         20okAaZO/JB3GpiWUC5nyhVmHBmidu9x4n6joYrUzRYFugy20slaayD+GCev3NBiW9Nj
         MeUbUBW3CIikFWdGOSVIQ4MfLZVX4poetK7NlOiYuU2yIUYXfEoqLYX3eMUB5WCTdpkR
         U4WE3c/035GLhQZiWM2lbd8AyGWJo5IaFVLaFypU1AOeXWr4qSUjt45nrrjwlymyaqal
         K4SY+uY2nXFsM1HkyHpz3Zk6WqtbeVgwWh5C5YyYsQR0lK0pM2+0H4PFGs8BuB8SgSOC
         ausA==
X-Forwarded-Encrypted: i=1; AFNElJ8AmCDsGkEP7HMeZ/IqBPnJ7grx0HxdL/7TTvWEg+5+H2hBqVsxgMzNMZ4/6KutnEBV6AS2n3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh8VX/BdOS+IsarYUY8A+5ipCpTwlmUyMEyVknXrkqhj0Cfi7y
	owvq7GO9I3uyj8/+Y8fK7JA4FyvEL5uJibldUs7rkUjqUWoePVGhy4K1
X-Gm-Gg: Acq92OGW54TPpnE4RjzlmE0XVK28Tlpr0rtLGq1C51TcoXEjjcIxCM+3qo7/YepQLQt
	INxgeO3lrNP+MEx9fFlbt2qRx1bzv9a265T7kMxi7C0uBqXEDciZgdXzgseTYqhJVKQhlweyjPx
	+oj7V8OyhzKFWtGUAG7pdKDIKs3uCbT8YFsVVyGJep/a665v4ArmIBP/xfu3Ma+dSphXFtvy71v
	jIXPKNfQUS170HMRKUtid82bpY59XNGwev5NpiRMXMwmBXCJ05LuXjgiLXkMSCSohLpiHIDCgIA
	M0Z5+khSxealYDXBOSuiOWw9AXRD1eA97ES43BNiOEPMidlpEIdMXk1zxSsRVMe/2HUFoDbdLx1
	EY9xm9axuZWttc4ly7qx3IORdYwzw4Tz8tu1AYEbCCnL6J4Im9IjzLR4T9gT2+mMum5daAd9RgI
	YKUwnb6umST10u4nQ4zFDQiff+0ISAXudgbvI/XSMDZeE=
X-Received: by 2002:a05:600c:1d02:b0:48a:5302:8ed9 with SMTP id 5b1f17b1804b1-48fe5ea0842mr127735665e9.0.1779094294929;
        Mon, 18 May 2026 01:51:34 -0700 (PDT)
Received: from localhost.localdomain ([94.158.58.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a562dsm35757656f8f.33.2026.05.18.01.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:51:33 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: andriy.shevchenko@intel.com
Cc: geert@linux-m68k.org,
	andy.shevchenko@gmail.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH] auxdisplay: line-display: fix OOB read on zero-length message_store()
Date: Mon, 18 May 2026 13:51:20 +0500
Message-Id: <20260518085120.926-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <agrKhHqSfKIb0N2o@ashevche-desk.local>
References: <agrKhHqSfKIb0N2o@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9B6EF5692C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-m68k.org,gmail.com,kernel.org,yahoo.com,linuxfoundation.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249230-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 11:15:00AM +0300, Andy Shevchenko wrote:
> Good points. Should I drop the patch and ask for a new commit message
> (and Fixes tag)?

The current line-display.c message_store() calls linedisp_display(linedisp,
buf, count) unconditionally, with no count == 0 short-circuit, so
write(fd, "", 0) still reaches msg[-1]. The afcb5a811ff3a fix Geert mentions
was on img-ascii-lcd's own message_store before the shared code was extracted;
when 7e76aece6f03 pulled linedisp_display into line-display.c, the empty-write
guard didn't come with it.

So both paths trigger the same dereference: zero-byte sysfs writes and
PANEL_BOOT_MESSAGE="" via linedisp_attach(). The underlying bug sits in
7e76aece6f03 either way, so I think the existing Fixes is right and no
respin is needed. Happy to send v2 with both commits mentioned in the log
if you'd prefer that.

Stepan

