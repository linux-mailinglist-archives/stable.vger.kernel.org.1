Return-Path: <stable+bounces-100483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44C39EBA1C
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41074188765C
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C182F21423E;
	Tue, 10 Dec 2024 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKobAHkX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132521423A
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858715; cv=none; b=Fi7e9bCY9c5/b9s8TdlBv5msAr4m92yeFCxb5WSbDrezBKp73/NcjwhH4XRPBjfZw1wjU1/eql2Uss7uHvzIcqyyZR4V7PHSsZAUh0TAn0E/7N3qRCEWHWAp+D2zGby8tGoW/g2Pv9ZwpMqd+A8fKhQ8xOC8Ve99MWEUzOAV+tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858715; c=relaxed/simple;
	bh=9t2Tf2ZN8jlen0Q6E6wiUicDdpdstkynNC+qBfXkf9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUNP29bRtVKdu2K0Il8HGjpdWZ8xR0G+fY1MgD6YC9uem9eK5TiKNx1rfQhLSIk0OBkChDLud7rsRkpGsbXsUEkM1V9yoDu78EEbIuGjHUca1vr5mMBoErVfnPBfHc0Quk6WMZi579ZKtnGnrrNJtNwXnX/zuKDlAvZnShBXVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKobAHkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F21BC4CED6;
	Tue, 10 Dec 2024 19:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858715;
	bh=9t2Tf2ZN8jlen0Q6E6wiUicDdpdstkynNC+qBfXkf9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKobAHkXJs2wGKJAkUChwiBZsN+264qpgqpX8BS3DO/hfjU03OCzuPjzjJZL4aMIC
	 BJTWzXKwqY9NrSctE6KSEi1KkXEdcPBVe8Ga8nVZjuIIFN2p89iF4Qy6wbirSiUkj3
	 M8hvAJ9tn18Y/73YAjd8b2IyN2X0jQkMKrggyS1XVJXhINGZkWkGUsCk/KwrS0K0jE
	 p98H2+yOuYu6gu+qRVTvX/hsU1bw2+SQTZddR1kuSGxwTPWd+VmxgfVojCjNuLlAoE
	 ywfqBHU9msF3SvUEEWeOnA6tNJX7O9y46NjLpXacIcakBjCuYTbXoOUEJDESHFaEVi
	 8gPD2x5dEjfRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Wang <hui.wang@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [stble-kernel][5.15.y][5.10.y][PATCH v2] serial: sc16is7xx: the reg needs to shift in regmap_noinc
Date: Tue, 10 Dec 2024 14:25:13 -0500
Message-ID: <20241210075831-42e19a5d0ddc1937@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210113126.46056-1-hui.wang@canonical.com>
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

