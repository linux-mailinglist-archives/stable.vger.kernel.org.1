Return-Path: <stable+bounces-96163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AA69E0C9F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A033AB61843
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3EF1DDC3D;
	Mon,  2 Dec 2024 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4cpi5ZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FBC1442F2
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166976; cv=none; b=LblfJOcKQreri2TNxVBaFqauOw0enXwanq+hOOaGPX3dkdZ5T/0+sCvrTJzRsy50z0G7GFY6CdTKWJKNKKbiWHS++kNIF8xFzOvgU0j9JlrvIdbVTod+eqhk1qG+wUYEcLTMlP6Lds5Qx4Poo3IGIhIlP4IBEbwooUt3rkwCIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166976; c=relaxed/simple;
	bh=/Az+hhvtBqhlIbI6qoyG3vBI2JK04wplhHsjMA/yTYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ok+MWOf16hVED+vVlBm/AR5gr7cS5dBN3TtNsGVZwxkXxgt4UGn8Xyi9jUSso7w4lF+mIl1nRDgr/jGmNyeZOszueYRrQQ+Otzz73HxfwSiR2BSvCy1Z8o0lLqrDoh58zRxT5TRYytVpmqB4rIE1IFXfm11/ZC5IiVl4MWVB7Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4cpi5ZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A8AC4CED1;
	Mon,  2 Dec 2024 19:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166975;
	bh=/Az+hhvtBqhlIbI6qoyG3vBI2JK04wplhHsjMA/yTYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F4cpi5ZHGSG856WMGV1CStxISkwN+DJZQ1YO1wOorooxfye1gdopkAEr4A6Ekt61M
	 WUQAZj0uy0D65SzyjSfgVkklYovE9hH6tppatRiUGVtwsaQ404CM7kmxllUvsk/RGv
	 YIB/xlhEdG3yAG3pZB6ccwPWq+sA4JfMbPXc0t+fCxpTLQfprY25dV5h7U9SBhM7ci
	 Sctf6m9IRgOikFt3HX40PN0TfSGJcavUJCPIKFJSbQvUtUrycv90Fq+RQRfC9Wshc3
	 Z7AoUao+93LkYLuAKi8uB6rI5JcqyHF0AEBPvHUoDY4KLBZmT644wtpIPThOsCK1dn
	 8NKIPWNdfwDEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v3 3/3] net: fec: make PPS channel configurable
Date: Mon,  2 Dec 2024 14:16:14 -0500
Message-ID: <20241202131517-fc149c7c7424f7e6@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202155800.3564611-4-csokas.bence@prolan.hu>
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

Found matching upstream commit: 566c2d83887f0570056833102adc5b88e681b0c7

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

