Return-Path: <stable+bounces-100031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD70F9E7DFE
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 03:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC2A166D78
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 02:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D68A3FF1;
	Sat,  7 Dec 2024 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv7tWNwG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A89017BA5
	for <stable@vger.kernel.org>; Sat,  7 Dec 2024 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537248; cv=none; b=UZjlJMSCTIdfhOipqrel/kSZLEo1nw9LLUx+R210Fy2hF4K3lrDWeNK34v0L7NjtxLWfEVApcmw1PvEiyQrW3Gt9j51TGfi76AwDTxeDEnwCIrgqj/3YiXwwUHM+ICAm6VzPMU0xSJ5zN0Hha1pSBnugbkjTZOchH8a5xDer5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537248; c=relaxed/simple;
	bh=9t2Tf2ZN8jlen0Q6E6wiUicDdpdstkynNC+qBfXkf9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdVkwVSh4ZckzRq/V4c/OpBbY7kanVVZcn9tTdo/u29a3id/6MrlDqIb/+PGbTMq4hsdbrM7rBR4Vw9w/SXISRedApU62xrI9ZHJ4mpoqnjLfuSYzZKidaMV/cHVP2J91fzhJAA/zW6MWbWhJQQygo3Am4QoOiUXwtyxr5IjahI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv7tWNwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E593C4CED1;
	Sat,  7 Dec 2024 02:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733537245;
	bh=9t2Tf2ZN8jlen0Q6E6wiUicDdpdstkynNC+qBfXkf9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hv7tWNwGlNm2tkO0oDw7IaanRqq8FlCMi3IE+IoSywauukxZgUhoo9cJiOLbjWU8v
	 59xtWuXunq3d/fbZMBv0aIEgxYn2sXeCn22apEnh2o1G/pin9zgxBfLXZTBe0G9gvk
	 nyBl5t6faqqC/DNCIzUOU90Xv/v0d+9r/x9OC8oMssg7BYEsNK3YTrdmmHXT1g7G53
	 havXuWZaR4hJ45ppAvESSQfqrzx0kwP9Pq+zKsiRwT62X57YZMPLPFrUQxM6raN5xO
	 I/0U1PzWiJ4LmyHjhrXz8yb2U4nKPlyytnn9iPeJtKT968qoPb+Aop0++pYpbinYhV
	 xvLa5pV2fmVKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Wang <hui.wang@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [stable-kernel-only][5.15.y][5.10.y][PATCH] serial: sc16is7xx: the reg needs to shift in regmap_noinc
Date: Fri,  6 Dec 2024 21:07:24 -0500
Message-ID: <20241206201210-0565ede2b23506db@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241207001225.203262-1-hui.wang@canonical.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |

