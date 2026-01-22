Return-Path: <stable+bounces-211219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FXhJ6b9cWmvZwAAu9opvQ
	(envelope-from <stable+bounces-211219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 11:36:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5631565551
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 11:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AA5B7AC44E
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 10:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8918B3446BE;
	Thu, 22 Jan 2026 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="Kl65nDrX"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628A2C0F89;
	Thu, 22 Jan 2026 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077757; cv=none; b=CcG8pLmXUYrsoJa3OTUuJTMkqAvYaY7AC9EBWregFV1AUFwSMsfSc9ahYZVe7TVjF9wqNDNOhloopI52IMWt4El5dh5t6i1RTKFGUASyBt31vZBSwQS9bZcwN5gWSIgn5bF/iEqWqM+PSOSR/iWuOxG42lgoFZby05wUjaqPM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077757; c=relaxed/simple;
	bh=Qo/Idojv7W9PxPMWg9eRWXP9+GoOHhCzycGU4LuQ0ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DitVNv8ADXsv+x5xReQowwzEePrnZgl8v6SuMs1Ym2Z6W3Rr0PWe6w74XdrcnkqBcpA3R9LTCyNPGjQzQZCf+ZiGjzrYqo+KBnLcZ0m05qR+TejJ//FuwrTXF1C3pPWcmOBJigLQ2POtw969+A3hz8VbLbw0g28BnPiwepXADNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=Kl65nDrX; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Kl65nDrXubBwKQ330Vkjy5642NylqNnNwGt3OeSHEABWIqNGZlTvMhpIi2uOfou17R/0KF5rcVw0k
	 O5OcFXF6GlExI/faZJHmD5Z3V2ZFB0md8p6B68co/iSJrMSGDy7L3zzXnglcnEfKy039klzht1tdl5
	 4b7H3+FgBCmbYNsM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-29-12034 (RichMail) with SMTP id 2f026971fbd3353-03391;
	Thu, 22 Jan 2026 18:29:11 +0800 (CST)
X-RM-TRANSID:2f026971fbd3353-03391
From: Rajani Kantha <681739313@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] iomap: Fix possible overflow condition in iomap_write_delalloc_scan
Date: Thu, 22 Jan 2026 18:28:37 +0800
Message-Id: <20260122102837.3379366-1-681739313@139.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122033826.3110454-1-681739313@139.com>
References: <20260122033826.3110454-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.24 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211219-lists,stable=lfdr.de];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[139.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,139.com:mid]
X-Rspamd-Queue-Id: 5631565551
X-Rspamd-Action: no action

Hello,
Sorry, I accidentally wrote 'PATCH 6.6' as' PATCH 6.1 ', please ignore this series.
I will resend the correct one, thanks.


