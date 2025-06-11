Return-Path: <stable+bounces-152380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDFDAD4A2A
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8383A5E24
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A87450EE;
	Wed, 11 Jun 2025 05:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KVFbsVbX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175368F5B
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618096; cv=none; b=UzTJflAI8nameKoa2PVRqRNRuLwByGbblvpa+TkJ4GOZ9FzJK6Up+2FHbagSluUT76rRsaXUNacnGLeS8ajrA/RNtaBPGivuOtaIb5b2XKV6HgZpWAU2FEjqk3OY6m4crEM4i4/uaR+gkNoEtOJ05YrGtOSlRfutknktHpZ/ci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618096; c=relaxed/simple;
	bh=moeV9sdxlF2V11GGItqh2eQnWD1Ewx5GstXEm9PTGbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9aBrt3mYvm7oVbA/NTsQuToPSOL/bCVJdjA7DBnEJsrnMgRnW5KGK/51dAgNdv4Su0pomFY8QXDPfr+Uw/xNoBQZS7BZDTUQHTN6gkz5Ix3yPDe6PbFGmLxWVdZzreoZdrh5pH5dTCCMMXhhxG9Vu2PbqxAR4kvXmFP2ug4z80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KVFbsVbX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso2745066f8f.2
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618093; x=1750222893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1IxDtWyGAzpMtyCqlJ68ugKUwtNgE+fHgH6NzMnklc=;
        b=KVFbsVbXtlrqurhTgoqYCpq+YjAkfDc05UUQDbUb/xMZrRTcWbgkdqES4HzcC9Ox9y
         FE4b5QfVnZ8RtPRPKQ/vJv70FmQ/YDoV96B1juloGvlXd7aoQaZ/iHiiJj868NtX3co7
         RbuxfvEabi3+BmhU8ij3jvmIJYFQsp5PZaOasHGBeEByGMKfLIf1qZaTQi42Rleqa/z3
         FvIH7O2PT9w21qQH4r+Jhvju9A3siOs0SshpUKULyaR1XE5IO+D61naCSDpRhgaBCF+n
         WVeJPAYgcLB+rLeAbxpCZ4afdelpd9tRCgVsi2Lx9rhWbyCyqdSUiR56T+0i2OAg7PID
         WdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618093; x=1750222893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1IxDtWyGAzpMtyCqlJ68ugKUwtNgE+fHgH6NzMnklc=;
        b=vhEg4is49W+FCRYEcQvG5lUMWhhwUGYUXM0lxhpVzShkU+kbi3wwnYZPn5/jcwMXnb
         Yq66TSYklpPK7jC9HR7Uy0HL/79tvg2wcd2AGqasHKzYw1DOi2S5yk8OvRto4z6TsWsT
         yM1OZVnP4EWCqJNt7smrRgYE+c1lC2uXkwJf/XsF84v4BbivXPeFW+1sxy4rDTfa6xPM
         DXk8ydcAoiM+yymjyqh0N049tdeqmGcCey5QCnwQxi3VaohltBCmZw9Zi19n7rm9X0Iy
         AF+rbGV+GLcpwlNgrsOk1YjLce3UBSPSo32N7dIisqh//ny1ZDxlQJohaajbjJrsbueC
         H8PA==
X-Gm-Message-State: AOJu0YxHF2Qgp60nML5eGx20AvvmI8M2WtBeIKxFlwIhPIYK8lb0snIj
	pNguO4Ko1LPvG5XWLv+0jhd2AhAY4MYynT4EGv0Ye3GmKa2KaDJsnjp8uMS5NWc/cCKl4HfB16b
	x/+CH
X-Gm-Gg: ASbGncsVi8NG+4A1aRFO8CyXfl0nYopvOC44xpdwFgdAaBCtPOY7jFQ3shGilfZjhAw
	yA2i6V1yVJaj6hQjNRjF/jWL57yObDE8s3PzPARyRQRRh/bmkF9Y86gGg1CxXJUsW4XLItKEqCG
	v+URdnW/8r8OLlh7HwvSUPUkoajVXE7hxDyAigaEw6H+5Aie+PQSn/aQdYn85F5iFF9j9ZmAgRS
	LAFWwTmC/qmcP83jbSX1DRrChRUibgaXpnlEpiInCT8RizdKc1iCWkfP6e5ElDI1AH5e3Yf2r+Z
	09mO9U/EvJeQwnNKEb6xQ/h9vLRUMuJNbfXngEcpsxrPtLV1ArldRJ5E2Nf89cpTTj/5DFvk+aH
	5hO+2AJY2CHQe1XEd
X-Google-Smtp-Source: AGHT+IFjhyV+04z+0T9kgwKx/zVpjibHS0QLeT0MSvMLMcLDv1do6tpaSjjSHyHIiG8S7nIBgMdntg==
X-Received: by 2002:a05:6000:2893:b0:3a4:dd02:f724 with SMTP id ffacd0b85a97d-3a5586e0339mr1184322f8f.43.1749618093116;
        Tue, 10 Jun 2025 22:01:33 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532468360sm13885875f8f.100.2025.06.10.22.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:01:32 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.15.y 0/4] serial: sh-sci: Backport fixes
Date: Wed, 11 Jun 2025 08:01:27 +0300
Message-ID: <20250611050131.471315-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Commit 653143ed73ec ("serial: sh-sci: Check if TX data was written
to device in .tx_empty()") doesn't apply cleanly on top of v5.15.y
stable tree. This series adjust it. Along with it, propose for
backporting other sh-sci fixes.

Please provide your feedback.

Thank you,
Claudiu Beznea

Claudiu Beznea (4):
  serial: sh-sci: Check if TX data was written to device in .tx_empty()
  serial: sh-sci: Move runtime PM enable to sci_probe_single()
  serial: sh-sci: Clean sci_ports[0] after at earlycon exit
  serial: sh-sci: Increment the runtime usage counter for the earlycon
    device

 drivers/tty/serial/sh-sci.c | 97 ++++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 18 deletions(-)

-- 
2.43.0


