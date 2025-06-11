Return-Path: <stable+bounces-152385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F88DAD4A31
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE11F189CB9C
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43212253A4;
	Wed, 11 Jun 2025 05:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QVg5P91S"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE23220F33
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618323; cv=none; b=FaoCrk1iylPLQtC5i53uGSyDPz2bCBdc7O+ykRwltztdwPst8AxWrAc+pQj/bR+hKNKYIueaYgFg7RU9pixfsovEMXw5x4xO8L2uBw6wuH5vEjsLGgWzkR1hOUBgTzcriCqAVMGjQb+PKLrybwwJ9xCGRqfmm5zWzL/a3n6RD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618323; c=relaxed/simple;
	bh=69rwhQL7gIi1fEq5ayQc/YCM+A9e89VLQQwxhpSkoqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMBlWa5SDwo91yU/5L8Z6Wht4LhNAZOclLTk/4djHtg+A/XUyJXz11bbdwAF7MX+HgfDcZyzmSTOfsaVzlrPfn4ed1WAO+MQIQi52JaqSIANFtZ/TKTmKebjNo+yitQi6DK2j70fNNvGq8hAuGvVV+wHy9B8Sm8NYMlF+PQxnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QVg5P91S; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60794c43101so6343885a12.1
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618320; x=1750223120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQR+lQ7gjao2waxWV083KVjFFBMiofj+DYTyZJrYsEw=;
        b=QVg5P91Sr7lFkHW4ePSkzx2pX8Tn97cPqkTHgkM0ntdhFaafLIlfGzQkbwAruW2v8W
         H+Ioj00EmsFf9bQTjCaiZqzLnPlnQHRFIkj3oaAjsltfQImPmDnXCu0fJVpEke50USvH
         arCEX19+RQk0JxyLGVBRqgDbqpzKxZlwbWk7O5bktC+OWFz/TnJIwwbLulcR28XGDkdP
         AD9MKPFQpsGbZoHdfgFeA/Qpv4g602yVPgLI4rsUXwYIVDEKbZ0f+nh5P22Vw/Ku2FIC
         Hduup/TJJhCGzWVFGz377cOnhKJIX062uxKdxBwh4VvLMgISGasmSdalEeSc95/OmBQz
         xdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618320; x=1750223120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQR+lQ7gjao2waxWV083KVjFFBMiofj+DYTyZJrYsEw=;
        b=f3hJyguOQCT2NKOJkeFHSw6xDTKCdlTVO6pnK99gXhleNjhagpRlElyrkXw1AJIC4w
         IO/CrtmHS+o1Gbv7PWvZSTcUEjBSV6KhSlvp5dpiT+8/oxQXB0PENXDHWFhmci22UYVD
         StSYPW0M9NoBne65jbSFPpAfxT1ozpiXthGEqs6dqDyA1RjQPrzmw4gzCCeoZa+jUbh+
         BdYjj0/g7zQa6HiQ51xxr0ej2KQohbbSW3AUfNtHFmwgW9oNHbKfN/59w2+Dl+/MGUE2
         oCLksKKfwzi11xvr2JSNt6pKlKP/aobu5BKSniZ03tbSP9nZMYPvgXAz2OWQQfJDPBYJ
         hwwQ==
X-Gm-Message-State: AOJu0Yyv3PI2BbSC99ZlvpNXqWslH0wTDtpfZur/0PafQlw0KgzNy0Ui
	2arH7uPxURBE7p2BLTV4i+MLC0dT9TeP3e2RP8/cofVoFrjhjVmyDZEoIDAR1cap4CN7T9JQ/7D
	sAS7f
X-Gm-Gg: ASbGncsmrXPZQT+7EUwNL+Xl5GQld2ZKgxk4iEAwUzlcgZ1xGlLFUHRzj201qD4GyyU
	JTEa/WJZLz+0DbB522bltpYDqU8kwPSh240opxWF7T9Sem8pYmLpP/LqDCF4BsA0G6F6qJB+wUE
	iAbRknBVXsedFDvw+aj92Zbzsjpxz9LA5FmwHXpQuJtdCtNpEiOll9ih11VSLXS5BywSfSNWaKa
	9dGwUPtOVMfK7ot/uDfq+Gvmju7QZHt8Omv6knCPvPO3PxI1lpWLQMmuoEeT1kSy+qT7fV6A4jM
	JnYs7a5vDTR5Dk6bbEXDOoDUBRDeS2iP22B1VsS+qItj9W6GFntjXAbU2ZgY+X9iE5885GOXmMn
	6/ize7DZeI8OUTNhH
X-Google-Smtp-Source: AGHT+IHxyCvLVIZVbrtwxFBAdcxNLqiCHiCAFIoG+EXc/HMG3+YZ5pJJlCyafg25GT1vVG3KV5Ykhw==
X-Received: by 2002:a05:6402:5114:b0:606:a77b:cca3 with SMTP id 4fb4d7f45d1cf-60846abedcamr1569391a12.7.1749618319759;
        Tue, 10 Jun 2025 22:05:19 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783c04f9sm6961577a12.52.2025.06.10.22.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:05:18 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y 0/4] serial: sh-sci: Backport fixes
Date: Wed, 11 Jun 2025 08:05:13 +0300
Message-ID: <20250611050517.582880-1-claudiu.beznea.uj@bp.renesas.com>
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
to device in .tx_empty()") doesn't apply cleanly on top of v6.1.y
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


