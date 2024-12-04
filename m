Return-Path: <stable+bounces-98328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA579E40B0
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4E92B3727C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4473120C474;
	Wed,  4 Dec 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0BJrdGV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062F120CCD9
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331200; cv=none; b=Wq/3FT1nwpHsd0Vb40pUyBao+UERkAt5oY5ZQRANiXQLngvW9/dTl4CVOEkHz2KEFdw/qHbiJZybgvIJnI/3Lp92XARbtiDtWrvbdcOm9zL/lUvytdkN+G8Z+Q29cMQuavw4/GVhAYRpCcML70zIKJShgs6EtSaXK0Cc2wO8L60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331200; c=relaxed/simple;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbYh1AfV4WHgH60hK5nSuRurZqBUpVxvH926KM7oCh3aJRV0Y2bX2xevvRvcxhXE/FeAqh0hIAzX35v6CHaxPk0viOVqLqwGkU5mNAfpbcIwVfvDyKrBsS5V6qgCTx8hNAJQNwMVPnNNyiv8WBsflddMxG9I+Lz1X2B0L4sKy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0BJrdGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091A2C4CECD;
	Wed,  4 Dec 2024 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331197;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0BJrdGVdSjp1JwmA1T7GUuSWAwM5wrLnyYyGjtFQ24yWh5CBBlAh7/edmsdN1Wv2
	 9rN8ruIvLZi6eOFcs17g6wkfnX/A9X5O8kbaRKGVjqFGNTZTCthoX7dZ0wNW4I5WwK
	 j+HBbp5E28w1CuuNXcVN/eKAUjHzfScNAzwT9lnUvfLjDSLATA8vJMEjf9YDp63eX6
	 KVOCNUGHj5Ncye9JODgIRB2is/aFFji5+oSBc4fDXK4dNXJDwwmPszmyuG+I9sA9al
	 EDHPxIoQFqnrzIyAXuR23TRl+iWEOb6ZyDBREEFV8SS0ZFVSoaDXBZjAcnqNgcNHFA
	 s1WkHxKiJjMow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed,  4 Dec 2024 10:41:57 -0500
Message-ID: <20241204072048-d1ee98d4a22f7b45@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204082752.18498-1-zhangzekun11@huawei.com>
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
| stable/linux-6.1.y        |  Success    |  Success   |

