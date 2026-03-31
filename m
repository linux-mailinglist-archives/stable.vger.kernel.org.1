Return-Path: <stable+bounces-231333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEthNgtpy2ktHgYAu9opvQ
	(envelope-from <stable+bounces-231333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:26:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 764BD36476F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1133302E90A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 06:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9583A450F;
	Tue, 31 Mar 2026 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2M3pV4O"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A517385509
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938278; cv=none; b=t2PuKNRRAASjV0Y9G44ACTb8GV8kZ2HFENj5v2KNYVounpDzhC1vsQm0wgHwHAeKxzoUyccfO8djBPO641WmrRc62cX0rKJTqzmyf2AN7YMkq1pWegMhhOTm4041V5vrCIyNoCFA5WSx+Qchuenp9UxldYtrXmRhTbTP3by6S+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938278; c=relaxed/simple;
	bh=vWlAHWkTCyA7++NZ0O2EqtDYUYeKrn9fUAwZU7E8i7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSbPytr3B+QZEPG6oygKolyoxNPmc1mhFvmAGAHUaiCGzXLWRUUXIGcpkAqiXGaVwEFbsrZaCV7fSj88J5A/OZvFRatDMhtUSk4NLm29YCz2dxxHKd5bGAnaUi7nj16ZahRwwF4ilQlDwX2lI3bIaYtHXWD29vRn91ZSlyyCq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2M3pV4O; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b0c8362d93so30538185ad.3
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 23:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774938277; x=1775543077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWlAHWkTCyA7++NZ0O2EqtDYUYeKrn9fUAwZU7E8i7s=;
        b=C2M3pV4Odr+GN1Pzxm/nYKp9vkvixRqq+dz4wFyJyIYCbZBgUZgjdPYYxpueZj2dWQ
         6PpH6VflVENLOpBFC9x5G9hh1Ziky9Lu8OVsHabY4trwhdKqpcYxd179S/iq040ok6n5
         gMzNQ4CnFDTD2+lSwa7DvELjbRfEgq5Ono3IYbkWhjTqJtEsrBjcrFeYTaNVbh/omWq5
         lTZBkVVH/Ib7Y+ELM+WuOm5zT3+Pl9WdxTGj33A9whLyutc91Py4e6H3fkXk0d9FxryL
         8jfnuRhNcR42usacAiYm4QkAKSQxIMHtqADlGMeOUi1P6pI88O3PfqLp21CVxDyr8vWm
         9S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774938277; x=1775543077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vWlAHWkTCyA7++NZ0O2EqtDYUYeKrn9fUAwZU7E8i7s=;
        b=qBWjzUU5Zgt+lgeOFzduqHGZZEWrzFKfO/qpPstDgsJ4MpTDl1NPJX4RD9MrdAtenX
         md7aKeJW9ZoSqesXAdlZ2/CTJDrZ6FGa8zvfUnJcJFC4g5q5usecp+m9lgQhCD7fz6Ln
         vaTdJssjtAF6tvpdP5GWOqimD42BKLpUDyYoSj7yDTmGaRu62XypcdGuuXCeyl0a/zRA
         GTeGpGAp4spGnjWTwOzdTD309LwrXGy6u575ylDc6592rFy4yypJGkwfe17SddcDlN/F
         nrBJsLQPzbWPLi/o/jRlerPjkxZY3UWAp2692XGgxgWQE7nLudz6vUnbkDQaAKGHpa99
         Niog==
X-Forwarded-Encrypted: i=1; AJvYcCUvWvYNhG9FgfW1vdBpEQCNLKGwhm1e/1IHuOkCZyVXr0rHyMIMcB9xAe3rBuNXDRrcwl5adaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycpL03oPhSbQX2XqGVG2tOJd1L7wg7UA+W31A5blEsVD2tgf5H
	c/eU1wfSsvc+2fnEvM/ro+cC7fWJIAggxiCz9Vn2UC31MWno7XyxKZ9R
X-Gm-Gg: ATEYQzzlEy+9kP5AFvXYNzkwIEJ6JFXmlp1TiDTp2edHOtujhLYyskdffN/2NkALj10
	CnpnF7hmAUUVa1Xv709gwOzkMWFjqmMyhDpQEYAmtrv6h+ui77ssKvLEYESBRCSZMBxorPGHP92
	6sGI6gS+4Ra59VRpGS0YZ3Nr26QQqSgWFDzONhCSS3eJVac91OoDI4+VkQ4cCCG5s8GmfSucV1z
	75l//1BQDuFbGaQl0ukBj6cKqhnO6iVI22EDXhQpcp1FYx2c34dqkKqoWz4IdG5gasR9Z5/0ISV
	Ipf5Tkp9wPF2uA3+MsmZT00KcfQSby6LvzgvbwVXtuT8sPgIpxZNDtFPbSFzWMeFlVdE8i7UPBc
	lGcPKv/GHtN7aBAYHPJiej9jb2AGDCk0GTU5nwzLTkA5pWh8aXRGQJCaNGuLakyPlnOptf/1x9+
	FATZrHb6YLkDwi3mX97UH9gFAGAiNAT9k=
X-Received: by 2002:a17:902:e889:b0:2ae:d09c:5241 with SMTP id d9443c01a7336-2b0cdc0332dmr160886305ad.2.1774938276711;
        Mon, 30 Mar 2026 23:24:36 -0700 (PDT)
Received: from f7eceb44c2db ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242676e13sm103873625ad.28.2026.03.30.23.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:24:36 -0700 (PDT)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
To: mwalle@kernel.org,
	pratyush@kernel.org
Cc: hd@os-cillation.de,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	sanjaikumar.vs@dicortech.com,
	sanjaikumarvs@gmail.com,
	stable@vger.kernel.org,
	tudor.ambarus@linaro.org,
	vigneshr@ti.com
Subject: Re: [PATCH v4 2/2] mtd: spi-nor: core: Fix AAI mode when dirmap is not available
Date: Tue, 31 Mar 2026 06:24:17 +0000
Message-ID: <20260331062417.26-1-sanjaikumarvs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2vxz1ph11jmq.fsf@kernel.org>
References: <2vxz1ph11jmq.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[os-cillation.de,vger.kernel.org,lists.infradead.org,bootlin.com,nod.at,dicortech.com,gmail.com,linaro.org,ti.com];
	TAGGED_FROM(0.00)[bounces-231333-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 764BD36476F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

> But if the controller does support direct mapping, won't it end up
> using the wrong opcode? Would it be a better idea to update the
> dirmap_info with the right opcodes?

You're right. If the controller supports direct mapping, it would still
use the wrong opcode from the template created at probe time.

Updating dirmap_info at runtime is problematic because SST AAI mode
requires dynamic changes per write:
- cmd.opcode: SPINOR_OP_BP (single byte) vs SPINOR_OP_AAI_WP (word)
- addr.nbytes: must be 0 for subsequent AAI writes

Controllers may also cache the template at dirmap_create time, so
modifying it at runtime could cause issues.

A cleaner approach is to disable dirmap for SST AAI devices by setting
nodirmap=1 in sst_nor_late_init(). This ensures all writes go through
spi_nor_spimem_exec_op() which uses the runtime opcode.

This only affects devices with SST_WRITE flag (sst25wf*, sst25vf016b,
sst25vf032b, sst25vf040b, sst25vf080b). Other SST devices that use
standard page program can still benefit from dirmap.

I'll send a v5 with this change.

Thanks,
Sanjaikumar

