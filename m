Return-Path: <stable+bounces-89099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F09B374C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 18:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594AF1C21209
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27321DF253;
	Mon, 28 Oct 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOYorNnI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466013AD11;
	Mon, 28 Oct 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135153; cv=none; b=h3Li6EgWkKNmcJIRerfLg3lHIjDTQ8+4I0eeXprwbowAsDaSVxdgijtdRb71xoi95UIAURPDoBTdW8g5pNHG+SXezWGTm1WcJP9sVL67206KDYhKRuD18IuS9MObj2/CjQC1fn8YvzDiAYpEtMfaN0C7D6ZmFV3TdHfj2BoVplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135153; c=relaxed/simple;
	bh=WUl9tGu/ZHWnr+Wy8xBi17tlJrUONW6ZV41BAc21ik8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uRguHJzkvhM1rYj+0nkjEQCxIQeCygpkRHIPLAytnUsmGgPpesLtdEtS9dsrfOCaJ0GqgT9SIABJSK7EDpSa5CNGtx1k0d7OWFupLNaHuaN7dLIan0Kk0UJkAJ3wsWbScKccEU7Wket/tpX7vST77tiAwoJ2Imq6aKGFexAO7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOYorNnI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43158625112so46266615e9.3;
        Mon, 28 Oct 2024 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730135150; x=1730739950; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sS2Swg/z54uGF96odFooOVWE7VWK0CxAKGtW04dKrYE=;
        b=mOYorNnI8zZEwbqdi7cevg5ZOc3Wu9PB58QshvJUUppqZPbz6D6kltLOw+1plio7W7
         3PhURuDE5JpOTrQZmX8x1XtOTALxyvJ2SeJJxXYDITVDX1DVQWAt4q8LTPV1RdGX+PsW
         7CBmikswt4Yz21rRtoUK5yx/dAvZ9YvRoB9uOYfdrKoeiHm9/TYPS+fTxidQEHg9bQGA
         szC1ps947w2KlM2IJuF+yoZ3qz8uDINw6maHfdwwzXJRQ4CWh9FHPg9/ilrlu+eTvmZ7
         KD/1vbfUM1mKY1QtBX7ffCEM0jM0+H695LQQw8lmV09TISio0GNN6O+LDw2Rq/Agkex/
         JWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135150; x=1730739950;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sS2Swg/z54uGF96odFooOVWE7VWK0CxAKGtW04dKrYE=;
        b=YEm1PWX39zO/AcTKLdhtAD5IuxuFyd18TrTt+F4yI4SG5RV/+xarfdVPU0TuaonLFx
         q+bkgLZjKGssj+PPASuIK68E1eEYXbYlRBM1M1sFgP3o+MGBcSRf9QPt8LZgOV4xs3Eb
         fOOof/Qbmyw396BGPMqhzqxRuHMRvMwozVn2+hbvEDy6E0LeoDVDtS+I4fHhZ98xQn7n
         Tgi/hVb+NNmW3Hr9lsq0MLmpTn/6c83lNFZ/quaLl7peJzxcCuv0+Ach6zawUFW7JEHr
         BNBVgB8k0E8kxWCy62F46X3shTqQNiIyc4HbwG6fuA/W2Bv60mrTQ6CsK2U0ShDgIYqu
         sBwA==
X-Forwarded-Encrypted: i=1; AJvYcCXxgfOWbSFUjdEx6Kn4AxGOLMtJBrDKTI97bzVC27lH00MU5vFcdX0kqxNSqs5SpyNAtCKWsKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLeEOVtoWk8iHAdVK9kcUwE+6B4PdXu3uk5/+injPATayf5s5l
	1cbZE2EmcIShYyXT6Gr6hwiCeSF/b+sEAxfXWtC/Qtzc7eGhjPNV
X-Google-Smtp-Source: AGHT+IHVD0HxXO939PBOrTLpBYsX0Cj2c3mMl4fUAWR0jNk7Cl0OYfEjAmneMVGvz8s6WbaIeqUE5g==
X-Received: by 2002:a05:600c:3b86:b0:431:9397:9ace with SMTP id 5b1f17b1804b1-4319ac95708mr80903255e9.10.1730135149476;
        Mon, 28 Oct 2024 10:05:49 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3be78sm10097655f8f.31.2024.10.28.10.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:05:49 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] virt: fsl: fix missing of_node_put() on early exit
 from for_each_compatible_node()
Date: Mon, 28 Oct 2024 18:05:40 +0100
Message-Id: <20241028-fsl_hypervisor-of_node_put-v1-0-dd0621341fb7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTEH2cC/x3MWwqAIBBA0a3EfCeoPYi2EiFRYw2EylhRSHtP+
 jxwuQkiMmGEvkjAeFEk7zJUWcC8TW5FQUs2aKlrJXUnbNzN9gTk3HoW3hrnFzThPEQjG4VtW1t
 ZdZAHgdHS/c+H8X0/LBUR82wAAAA=
To: Arnd Bergmann <arnd@arndb.de>, Timur Tabi <timur@freescale.com>, 
 Kumar Gala <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730135148; l=852;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=WUl9tGu/ZHWnr+Wy8xBi17tlJrUONW6ZV41BAc21ik8=;
 b=0stlbmLH0FvPnzod7+/LoxqKO+Pj7FF77LC1JMzix7ZWj6iE33/T7524N7P3ZOAjpr5LZ761V
 4G4T3PFgzHXAM4AYM0mndBZE+NlVDW1/OXVTMJ1xKhCIJGZl932tSZi
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This short series fixes an old bug that only happens if a memory
allocation fails, which might be the reason why it was never found. When
at it an unnecessary jump to a label has been removed to simplify the
error path and avoid jumps out of the loop, which might have hidden the
bug while reading the code.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      virt: fsl: fix missing of_node_put() on early exit from for_each_compatible_node()
      virt: fsl: refactor out_of_memory label

 drivers/virt/fsl_hypervisor.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)
---
base-commit: dec9255a128e19c5fcc3bdb18175d78094cc624d
change-id: 20241028-fsl_hypervisor-of_node_put-5051e664f038

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


