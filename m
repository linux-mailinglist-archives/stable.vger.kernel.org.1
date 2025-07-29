Return-Path: <stable+bounces-165143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F022B15483
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 23:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84C35A2E13
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEBD239E60;
	Tue, 29 Jul 2025 21:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6WuKFj6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D34619F13F
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 21:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753822987; cv=none; b=V/77W1saIz4WFUgkDkveDIdGWQ9HqbKP8LuZYJmpKRqi0HVqbW0gNBbbOCcO1YQ+0jsvBuSz07sdxWeJ2ze/k417RY38bGe5RXmw86ti7ljY9KtvGto9C+FDPksfWIKKddacy27IFQWrsVUXjWAcDFTQqJQ3kiyJL4ZZnU42In4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753822987; c=relaxed/simple;
	bh=JJKg/+rpK/xb7Uoz1ww6/mCaEDtauIPWxxSVM10r1Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0lUBJI3EcLKvBFALXclOF55gG4+mZYrucPh5u2JClz+otgc/JGyo6wLWmahUUTJLzGHGFaGbtQNPQosLtmiIzHAOsChGZoHbz7lKfQftoQJvztLIA9hPcAVlFLGqEjipuIcP+u+h7qJgRfIZiu19ff9/RKtdoiU6s8zgsMVTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6WuKFj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C70C4CEEF;
	Tue, 29 Jul 2025 21:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753822987;
	bh=JJKg/+rpK/xb7Uoz1ww6/mCaEDtauIPWxxSVM10r1Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n6WuKFj6tS9RqLMXlnKV73Nqk04JLvh5sm2jPEZigNrA8V1hKd1jexbMfS4G3yfZd
	 UYpbWEVxe//jOeFAw5gc+s9P34VaktybtIP45PrRQh/AD4J/ziqnWv1jqpNEy/qLpG
	 F0xIuWGAfKN99aWFZezbRnztW/XDmeewiP5KvRY259a2zuNCLHD9etbr+5TH+DejDL
	 QI27hKDKivdt9C3RX3DdrhJIozRUfL7nc7IqgZIapUPuDR5OkNoquKplMSXpF8ZI0a
	 xjfNMtsYUzO2BGfOnBop5cuAuMp771L9bLzsGKbi/uqr04iJm0T6SGZcP97VlS6TCm
	 rmXeHEAnx4xQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tomitamoeko@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 1/4] Revert "drm/xe/gt: Update handling of xe_force_wake_get return"
Date: Tue, 29 Jul 2025 17:03:04 -0400
Message-Id: <1753809157-d239d958@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729110525.49838-2-tomitamoeko@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.12                      | Success     | Success    |

