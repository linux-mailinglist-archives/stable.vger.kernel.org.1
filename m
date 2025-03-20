Return-Path: <stable+bounces-125682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE57A6AC88
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 18:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6911896389
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72C225795;
	Thu, 20 Mar 2025 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKx9Ac4z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083C22577C
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493304; cv=none; b=a//K3e57V5FGgvu8z0JykcvY1QcO47vsBBLljtlix31vLom58UTexMkRUqzeMobpaNsspOsAoqZHKmYn/iSOAGAqtQ9uyIMsIxNJDQkSnkmvRMzPanx9yDAvNBWBklLW0E+ttTFkAsEtBZVWtUcQ6E4iijriZ5KLTx6FF8Cqs1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493304; c=relaxed/simple;
	bh=B2gDPUd2fKZwTFakJb0wiKXLEtauw4VhJgB+SeCvow8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ABfuqLypLSTtH7E2Xz/43lenHzjP3v0QyFOIEaP83nxgqtoibiBErOe/2Xp6Ov27i0jreXF9B2cBx585EC/TtUKcO9TW1ZHBmVASNUcRL45ccwEeKMJgDEYFU4Ym2d3TxMxWFBR4SrEBy6muvJ6z5yEGktdUnDnvpRheofQin3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKx9Ac4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA18C4CEDD;
	Thu, 20 Mar 2025 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742493304;
	bh=B2gDPUd2fKZwTFakJb0wiKXLEtauw4VhJgB+SeCvow8=;
	h=Date:From:To:Cc:Subject:From;
	b=aKx9Ac4z1EZ4TXujWewneWwvkggGxyF1wM3qFfQtGId3DCdFoN201uQKoutO2rz5O
	 4s1fIYKBcyq9ltwPsI4akKOK85e+YnJcqiKhuIGvT8AM6BPdIiMuK8s75R6GgOG0Er
	 l8f1wZV2xU1Vt95KeO+icxDVxGNxuZ3qsyLb7j7QMClXgXZ7YB7eKR/E5azv79kB5P
	 zbVeASA+ZWu1QFPaQBDM9srfn/Aq4Pd8z2+cCEws9TkheYrILUlj/SaHLYl3riMWEH
	 kCxKS8NDfsP1fjlKhHnqJJ2xzm7t6eafWirbnrtloQubrbV28ICptaTelfRVxjal5a
	 0QTcSwk93CyAQ==
Date: Thu, 20 Mar 2025 07:55:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Request for backporting c4af66a95aa3 ("cgroup/rstat: Fix forceidle
 time in cpu.stat")
Message-ID: <Z9xWdxsAadLyp1SV@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

c4af66a95aa3 ("cgroup/rstat: Fix forceidle time in cpu.stat") fixes
b824766504e4 ("cgroup/rstat: add force idle show helper") and should be
backported to v6.11+ but I forgot to add the tag and the patch is currently
queued in cgroup/for-6.15. Once the cgroup pull request is merged, can you
please include the commit in -stable backports?

Thanks.

-- 
tejun

