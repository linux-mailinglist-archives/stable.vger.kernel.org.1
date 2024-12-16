Return-Path: <stable+bounces-104360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D342C9F33CB
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11303188A06C
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6BB288DB;
	Mon, 16 Dec 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFmnGmLA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8E20328
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360833; cv=none; b=s5VcRAUa5vyCupWqtGeahcBqGgOEZ1hwVh/oz1AQTrNFmNH9EOfUledba+E+shh8nJ4LmVXAz1DiW+ysniSvetKrXKADavEOrbQaSAWPYIYqcUXAcxSbxkr4IyF2OuOZQXNKY0VQegpdcEzvXMejyHSSAE+ZNMzycflzzOdFvWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360833; c=relaxed/simple;
	bh=8/DJ1WlFUJJpAnPWqt4Jzm3bhEEC1BLLhSADFTNCrkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/okH5BuO2b37BUCSRRjp/QFXNd0TqSXz3n433iIuxEjbGBGtiZDc4MgGheon18iMaRomo0UQhVSIZfpziUPLZuUl5F54wxMslrujSuTdCIgjB5cMifezjw37EqJG1pf21HX1W5WrcURkpy54ria5zaeffIP0U2zdQMr08aD9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFmnGmLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E677AC4CED0;
	Mon, 16 Dec 2024 14:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734360833;
	bh=8/DJ1WlFUJJpAnPWqt4Jzm3bhEEC1BLLhSADFTNCrkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TFmnGmLAZfAm3JTdw9q/wMfU2QtlH8FYKHIZysXQtUGf0kQqno2+B/0liFAhva6gu
	 47FvCLdTo0aCl55vVFRRMDu7FVuKV4pQIQ2kTpkJEh9/ZYwph9Aash59vUAbUBQ4Sy
	 6Sc4A573cn1u6a1B0WZhS9Tg6zgSMFVf1nCLisOrZ/BddsqFHEqz76tKRVcwD0vpKW
	 QMsCDQ+vYmGX4AJ0T4I6X9SdsI/FsK6IhkRxw260GaCP7kRaiMwuexUlVXzk+5jt8X
	 +BRom7oo/K0WFaOI+VXulZU5RG47IXMJVLuIWRmMwBsez5EcIXWyPBV7nn2/+OcIfr
	 2jAbB7JKP4jhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolay Kuratov <kniv@yandex-team.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 5.4 5.15 6.6] tracing/kprobes: Skip symbol counting logic for module symbols in create_local_trace_kprobe()
Date: Mon, 16 Dec 2024 09:53:51 -0500
Message-Id: <20241216081721-187c6625ed01b125@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241216111923.2547104-1-kniv@yandex-team.ru>
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
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

