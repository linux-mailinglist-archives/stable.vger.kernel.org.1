Return-Path: <stable+bounces-185460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3C7BD4F72
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73916542F71
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106883161B5;
	Mon, 13 Oct 2025 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYUW9qPa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC7316189;
	Mon, 13 Oct 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370355; cv=none; b=YdRUTXL3Dh1dSpk4RibwnmKFW9jrgeuvGd5Jph36KeuxHa3GJnJrIPXVjBkQ1b6lydqcwknmWBC2m4hZlqg2sTP9Er6VZEUsrI+ertVKg3z2ukY3C8bjxuDEMH7aRzOc6JTJIbNevYwg+MpYvQs5sYYTSlpyEObn44IOL0m+ddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370355; c=relaxed/simple;
	bh=LeAinlflwroLH39UMkuoYrzP/zcIczpDGmXsjdPlHgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IL2Xe8cJ7FNAKo5+upsS1ze5K4hwRqnLeb2KBbYIGaIvUlaJOwWZa3VSWctYO0sUlIY+H4qyWNzrVQdpaLOb20Zv6i+eeh09aT0pACPF2sYAI1BTSHMQZOLOuPIbbAMaWE8w1Trqhx5niC6CEnFV45w/P9uOSEFGvWc/6BxuU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYUW9qPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC378C4CEE7;
	Mon, 13 Oct 2025 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760370355;
	bh=LeAinlflwroLH39UMkuoYrzP/zcIczpDGmXsjdPlHgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pYUW9qPaHKLbQ7bSKF7hmBIY6bzhAA4m9e8EDm3ZMMxjoXe/lpJgOvKAqn/ZKFOrt
	 99mJQHNyAHIMR2ziTO8t1w9MC/sgbqjNBPHTL/ULvPpj7BvnWb+lb3n1nNvkS6/Sgv
	 /b5s7dHmw8SRnSZ4WfL1K1ZUgc/VpcDtNzI12HAuv3UipKtIGvVtkoZ3Vv3yc+Dfjk
	 bI20WGnNPmrHuzI1BXFR+wzpR2yFqfklsCOdym6nw2YWomAQEOZ8nPcNtIbwmLSCUx
	 uYUgsxBwdOxB1zoeph6TwA5K/xRVtlqycHMcDI8Qj/O47TLe+7+G2NF4iQV2zwPqaa
	 aV7hC4YM5+BLQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: miquel.raynal@bootlin.com, mwalle@kernel.org, 
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
 zhanjun@uniontech.com, niecheng1@uniontech.com, stable@vger.kernel.org, 
 WangYuli <wangyl5933@chinaunicom.cn>
In-Reply-To: <20251013124129.708733-1-guanwentao@uniontech.com>
References: <20251013124129.708733-1-guanwentao@uniontech.com>
Subject: Re: [PATCH v2] nvmem: layouts: fix nvmem_layout_bus_uevent
Message-Id: <176037035373.167410.13039590112117354524.b4-ty@kernel.org>
Date: Mon, 13 Oct 2025 16:45:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 13 Oct 2025 20:41:29 +0800, Wentao Guan wrote:
> correctly check the ENODEV return value.
> 
> 

Applied, thanks!

[1/1] nvmem: layouts: fix nvmem_layout_bus_uevent
      commit: 8b6322da3c1fd814c2293525f69b776b80fc6895

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


