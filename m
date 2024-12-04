Return-Path: <stable+bounces-98329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339C29E4022
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED494167536
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298E01B85D2;
	Wed,  4 Dec 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJgcpahe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72420CCD9
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331201; cv=none; b=gO071KDhfAmK7lJ/FSkr5qrByfyzVQKvKhK0zQfmRIVgQswQMnHy+hKejjhQvdPV5viNLMTRkyhwnoakfguBvTuLgIHgZiz9SUYdsglmtwYdy6JM6O9ADqqO4j8Xj3hZVu3BdTJ/U59Cq8KFg7n0f1zwTHS6ShO1bjreDtSHCDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331201; c=relaxed/simple;
	bh=WfV3Jso+sLZLFfF3Ui1yCgxVJmuzjPQWKs0MP8BQN60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0g0P2rr/7Ut6SbCB/X+dQYt6ql33/3SLxNnroOP4neBxxDsTDTff421SVCmpBE75MAOk50Wtu+YMHyd2SpsMci/r83GcfaQczOS2IX3lrmMRSI7SWNYr+DBVsel+NmGIA/1BkKop0g4q99cFmvIW8QDbkaw0c7ENq4dGKVK/Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJgcpahe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4EBC4CECD;
	Wed,  4 Dec 2024 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331201;
	bh=WfV3Jso+sLZLFfF3Ui1yCgxVJmuzjPQWKs0MP8BQN60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJgcpahe696ResCsQvAc2COyd/hWswsRVw0exNx2BDLjV+Y5EKOW9Cg4i4zjOJYnm
	 SYYciSIDLx5cH6UdT3qKXiasbTg3Dx0NWnht3HyaRIkFy7ZnwLrrLz1PiAd8tlyTyB
	 3/Mp5Aesd3SCtGL74rx5YMwnXm3/4Tx8wfaetF1HWKo4n9g8B9HPDoZx5FGkX7wRn6
	 M1uOOJhkdaVnRKH2NrNwx9TM4wtn1kHm2oUdz4lq6sFbwP1T8kMpTifjsgwUpGSsNP
	 Y3mZTfiZYsgmoezIrbECotsGq/ks3QZ2Uzg1VQLx2l9tLBnR/+lXvW3tZtS5roBuPy
	 zi8t9ebyHgU4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed,  4 Dec 2024 10:42:02 -0500
Message-ID: <20241204070128-b73be6c1e5cb2818@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204082627.3756-1-zhangzekun11@huawei.com>
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

