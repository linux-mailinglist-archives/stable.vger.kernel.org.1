Return-Path: <stable+bounces-155221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1865AE2826
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080F83B3F12
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6733A1CD208;
	Sat, 21 Jun 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZHEGvUh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997B1DE4CD
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495933; cv=none; b=WPdlODNSXYUjH7PdMzv771fgc8IfedDDpi9fx8lureW1xoZC7WyU/UgIKTG8pvHU/NaCDyBzhkjEG7h49q1JD5vASwzg6pO/ffX7uQvIcDRd6Al6+eSvpcxfgf2XZCY7CrlYI9ZXQbR8WgtZkBJ2fSnxaFWq2/FiQVmC+P3bouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495933; c=relaxed/simple;
	bh=Pr3kj9rPbI0l97MNAYBzmCHp6Y9FcihMoc13r4hT/Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AvQdku0YItZ6/EQMK/RxqkmDCv65od7zeEgYMc/d3CyX1+M2GkqmfNPsLzv7g6jD7EMSXXKrRVdD5puZbf1IG0cBIW/bVmHsk81C950tls7kvgF6a80EZzF9nAKQGqM9Hu/wEUQa7YT8qKzOm+DBjCc+g9JhnEL+9fxT+JqzQ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZHEGvUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F026C4CEE7;
	Sat, 21 Jun 2025 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495933;
	bh=Pr3kj9rPbI0l97MNAYBzmCHp6Y9FcihMoc13r4hT/Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZHEGvUh5w0NXbuldJwCqD0cqG6ojW20ZwdO1nasF1BpvHkby71U8Ted/G5Lxl5jx
	 rnRAMkILOZ9FritC8uyNthR3RxGnlT6m8PVzXKyrpwa2FQ5rQTzk3yEHByeG9q+V4d
	 lrhCOyrhOFwerZ/6WJYoSmDuTqaDl9xgd4vuGaSeP2BUI08mic/EHJ2XpPW9Q1D82l
	 rKv3FHU3/0tuVwUf6e0O/SwceCbeKfJl7Sj+8eX5BbKhLlO2tcSUtrgJ/K8tsP73zS
	 DHc8aS8yYT3XD6ny15cZkXLbYTF9RRC6AlVdq5bh+zV009ha1j4pnHzmAzVIn+G6d9
	 86D3DNWA0yWsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	peter.ujfalusi@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: sof-function-topology-lib: Print out the unsupported dmic count
Date: Sat, 21 Jun 2025 04:52:11 -0400
Message-Id: <20250621025925-9c4b9071dd2f6291@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250619104705.26057-1-peter.ujfalusi@linux.intel.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 16ea4666bbb7f5bd1130fa2d75631ccf8b62362e

Note: The patch differs from the upstream commit:
---
1:  16ea4666bbb7f < -:  ------------- ASoC: Intel: sof-function-topology-lib: Print out the unsupported dmic count
-:  ------------- > 1:  a2b47f77e740a Linux 6.15.3
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

