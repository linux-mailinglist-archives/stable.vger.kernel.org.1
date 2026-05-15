Return-Path: <stable+bounces-247327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KETAKEKlBmo6lwIAu9opvQ
	(envelope-from <stable+bounces-247327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:46:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 075A254951B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A112B30125E6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AD631CA4A;
	Fri, 15 May 2026 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0BKrxp7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45419D071
	for <stable@vger.kernel.org>; Fri, 15 May 2026 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820412; cv=none; b=Ssk/RF0UvHCNYEgYuzZG5zZovy1Gwxyrsd05JfoDxhimi/JTho/4U9S1qwkRb3iYWTvl8AxAP9EV8N7M89rX/aX5p7D6+undjyBzr78/bqYGgrgnbGhgClKpM8Kg/7coA8AJvrgLwzZzXULl3UcL4iUsZHlqt5oczeCf7NUvv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820412; c=relaxed/simple;
	bh=DebnKZBP3fkff/DtEEsvGg42PDXBlj9dtaWP19buPrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GCoJcIoXYAKrMcreFR41wZS/aNIWVPCFdGyGGT3gZHwYqGbPT7MHvpRbOvQ0agj7buha5/ORR+fqno5Fwx4mQlmLRZdvPrwJpDSkCGRZaOEVDlKsahGW8Vb/BBoWT3awTt/OWqd7NWkrc3ehjWOe9ZVlfrMroLKN1janBofPdVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0BKrxp7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c80167f56cdso3730991a12.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 21:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778820410; x=1779425210; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DebnKZBP3fkff/DtEEsvGg42PDXBlj9dtaWP19buPrQ=;
        b=W0BKrxp73WlwKXtCElsfEu+e7mcwrL3H0LqSUiIlcfl4olX4SMmG1IOYGmowaPoilc
         baXJv9XGSnXja7ct/pLrp2mQAY4kJv2NBEEpDYNl61rHEmFAx0yXgLgWvxc+85bZPz0Y
         4QZFIzPam4O1fqD4ZrATFCFhNfZ5EKLx/KecS817SUjDJjJSraWe4LWgpCR8e2H+h70M
         NPqgx8GRZRoxhql04L94Row0sJSdP1bPAe2du7+UHRa7IWBIRLBCDnQgSVqHR8vE1z0q
         YI7zKvuLx/GHgMKndY5LJ3QUZ33b23/zrxYtNWcp+V9/+bw0zRDl/VfZXB3GyDtuDEDH
         rlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778820410; x=1779425210;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DebnKZBP3fkff/DtEEsvGg42PDXBlj9dtaWP19buPrQ=;
        b=roFWhHueB67ooNe+14H6DcUSiwTUm/mHO+nI+L6h5HAajvclIQ2E97FdvFlwOF3/7H
         aCsngM0XreQ9Dv8YwL0vTwhWl1XCZ5RHU1PDAHuyuI/4KqXy+gLMNIgPXtTAf5v5lqzT
         FJiIbX6Ocd+tX0gbGZe+MoxThlxzIKFVe8dGy6LfUi1V3xBJDpX8mulwB0Bi/bC6tYHo
         /WifivbU3IFLjZgrmm7eSYH4UuhizPJedCvFNb8LAXgGbesOwCNQ4bhXh5BZBYrN14k4
         oDTKDC3oVxFlxDvUhwlmxrF7jn4pr/BetZPac1gU9Z32qFUYSZHceZzYCUVE+Vh6p6ku
         Uscg==
X-Gm-Message-State: AOJu0Ywr0skhhxGFCLyDcqWBxlylGzIsV75O/aOFJjGYvtoIF9oeHt+u
	2+zc6Te3xWL/k92fnYY/hJc5EfmjudKfRI8Z/7kg8qI2T0FL7rAkEhuTbRfU2FfE
X-Gm-Gg: Acq92OE9NPRABV2lwrJ9zyv0x99uxzp/zyvC81RSqMneUIWLlaKZu+b/00kmtqgWFLs
	WGORVU79UhSIlNlf0yutaRQui21n6Ekhf1U2DisTPYGd+sx8RvMbyOuk/w30xYygn1+0wFUQfhC
	zhc4WWfERGgx/iqPFWKIXwKiG0QEaZnb7sPIki1g/3K6lemrY5cHpemai6mYWVBwUcgJ08Oexbc
	z8XJKXPrXY87hvQFrzfO6TMkb2IrkpqTVf5uVVod/6UO2xCMOjktHBqGb0yPNdLCIQ+QUbi7aiH
	TVDH1x3Ny9Zsd6o3wEWt/Apjo7jy7gqW8ioRBn31fB5tFbdUKg00G+whkG+1hg81Wnp3XH6c2A7
	Fwy2HXvpHwNr3/vQsA8ItXkWA0dC4+23x9+wYUOjZfkcLmIeDK6UiHDmlLw1yKH5k7Z9z+piglS
	4vBh1PNJUYq0HwP0wM6vAK55sAaasQlqQ3TifzUc/rVHANU4jpIF3nO8UePMlpOqZ4WO2RvF2Ke
	3X3JXx1mi08DdLXTrAe
X-Received: by 2002:a05:6300:218e:b0:398:9662:10ff with SMTP id adf61e73a8af0-3b22e6685e2mr2801258637.4.1778820410478;
        Thu, 14 May 2026 21:46:50 -0700 (PDT)
Received: from archlinux ([2405:201:1b:225f:36f2:f474:be1d:cad7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb102415sm3991830a12.19.2026.05.14.21.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 21:46:50 -0700 (PDT)
Date: Fri, 15 May 2026 10:16:40 +0530
From: Krishna Chomal <krishna.chomal108@gmail.com>
To: stable@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com, aros@gmx.com, 
	platform-driver-x86@vger.kernel.org
Subject: Please backport e8c597368b85 (platform/x86: hp-wmi: Ignore backlight
 and FnLock events) to 7.0.y and LTS
Message-ID: <agaiW9AmqFwsT7pZ@archlinux>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
X-Rspamd-Queue-Id: 075A254951B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,gmx.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247327-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishnachomal108@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi all,

I would like to request a backport of commit e8c597368b85 [1] to Linux
7.0.y, and LTS versions.

On new HP OmniBook 7 (Panther Lake) hardware, the keyboard backlight
and FnLock keys are handled by firmware but still trigger WMI events.
This results in "Unknown key code" warnings spamming dmesg [2].

The mainline commit e8c597368b85 ("platform/x86: hp-wmi: Ignore backlight
and FnLock events") silences these warnings by adding the key codes to
the keymap with KE_IGNORE.

The patch was merged in v7.1-rc1 but missed the stable tag during
initial submission.

Thanks

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8c597368b8500a824c639bfb5ed0044068c6870
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=221181

