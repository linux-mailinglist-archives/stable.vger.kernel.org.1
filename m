Return-Path: <stable+bounces-98584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BA89E48B5
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C0A281E05
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EDD202C40;
	Wed,  4 Dec 2024 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWdX3zJ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53798202C3E
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354597; cv=none; b=eYvSM/XqhbRvafIJWO8kQxIzInOzJdQPIKYDX4UOK9vW6rSzRb7et9eC1hAEKhHdUV/3vlEt75g6odYtQVEUbhdQ6oG4JW24G5pJud7oUCyOUjbfIFUF3DlRxA0eHKkb+sClRDKJ5S9vhkrt4sx9nJhfBhg1AU2YmqW0ZAdwCpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354597; c=relaxed/simple;
	bh=yfiVbh6++3g9a/iK3qpK0ELDU4TCwD5+PTtLby3uTes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhaDE7fGzAxn36tNnL6qINgeor6SEVBW6/rDVyGkmqoC7DlQNezOAJchpRL6O/14t9bbTOItMGsrpVZ20HNrgV7xgWvvkvN19DdUYCeMW/svKxb1eFnc3XXRy933qDbxQ94u531oItM+9rkOS7WkUHMAl/0Um0EEsSMfhJ1yC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWdX3zJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9A3C4CECD;
	Wed,  4 Dec 2024 23:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354597;
	bh=yfiVbh6++3g9a/iK3qpK0ELDU4TCwD5+PTtLby3uTes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NWdX3zJ2o59Rv4x2YbxgaGdTg9h6Gk9bY2vlPFomsytEcfDq/JmxylT7Oe+vVYoRK
	 MGIf/+NukR6ATs9i4Uv5uOVMSbLAlKgxydl1+Fxi2NLbFVV/VIIOmEFMDWGg6w3UZo
	 Lxn4ONk3xUKu/EnG5UzbitQTULZ9+degJUDITZua4cyo58zYdA0BiuYF35WMORtgV1
	 AJowCU1ho7V53+mz+VBSzazhrol1Xw84tui28nV8ijkLhzFn9e2afhuJ4kwptmJocg
	 YfkkCoLV5lmqI2tVzZzVHtu2dr5CCciQn/eUMR/hFp9P4Ym25lUY7ZmByrUxHQvEh+
	 3/9EmthKuRWFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed,  4 Dec 2024 17:11:57 -0500
Message-ID: <20241204071451-3923f78cfc9a5645@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204082356.1048-1-zhangzekun11@huawei.com>
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
| stable/linux-5.10.y       |  Success    |  Success   |

