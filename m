Return-Path: <stable+bounces-128913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C98A7FC32
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC85F423846
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D25268FCD;
	Tue,  8 Apr 2025 10:24:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A1D268FCB;
	Tue,  8 Apr 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107854; cv=none; b=iRj+H7tT+gOEB6ZIY60OwotlxYiW1nSauyl74wKzw79YPvnTbDq4/kP+TwLqHkL2eI2THyDjG914jiypgcY1z4cD6vE1f5Y9/y5gXM99oCefXTjLOWZ3y4NxfEBoN+npAlxDeTeWWW1fcox5Hk7ir8t2pRGF/EQbtDuqT86vG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107854; c=relaxed/simple;
	bh=gtWIzfgt/GXFjVQlntGWbVt80yuWJ2ncZZYmKlDInXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdijV15ldY/awC4OSOmn76UFEzZRE9yLJlmQ/yGdg7a6GxyVZ3RUPjrJoAdBErLKhPSQACSgblLbUxFSiOtO2ARX31H01qHUXDpI1appnqurwEfbmqISgShDjUJwxGNQ+lijzSPvpyBoSOn4oSiSQMN46rYZH1O8jMaJpswQE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A4B61688;
	Tue,  8 Apr 2025 03:24:13 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E03173F6A8;
	Tue,  8 Apr 2025 03:24:10 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	dan.carpenter@linaro.org,
	Huangjie <huangjie1663@phytium.com.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Fix timeout checks on polling path
Date: Tue,  8 Apr 2025 11:24:06 +0100
Message-Id: <174410781232.2545069.2779905512336783485.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310175800.1444293-1-cristian.marussi@arm.com>
References: <20250310175800.1444293-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 10 Mar 2025 17:58:00 +0000, Cristian Marussi wrote:
> Polling mode transactions wait for a reply busy-looping without holding a
> spinlock, but currently the timeout checks are based only on elapsed time:
> as a result we could hit a false positive whenever our busy-looping thread
> is pre-empted and scheduled out for a time greater than the polling
> timeout.
> 
> Change the checks at the end of the busy-loop to make sure that the polling
> wasn't indeed successful or an out-of-order reply caused the polling to be
> forcibly terminated.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Fix timeout checks on polling path
      https://git.kernel.org/sudeep.holla/c/c23c03bf1faa
--
Regards,
Sudeep


