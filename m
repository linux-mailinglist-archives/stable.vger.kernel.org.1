Return-Path: <stable+bounces-7-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C694C7F5696
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 03:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E76B20CF0
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 02:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270BC443E;
	Thu, 23 Nov 2023 02:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nttzc42Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE51F4412
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 02:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E51BC433C7;
	Thu, 23 Nov 2023 02:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700707938;
	bh=rRbIXqjq8DKBA6vW+7glleky65j8TQodsqrm6IeWtY0=;
	h=Date:From:To:Subject:From;
	b=Nttzc42YdDlHL5kMDrQou8O9f0q2MEu1DP6d3UzXeDq5AeDgnmx3HCyXeVHJyGDWL
	 EWdGxd6kPO5VmK6Wt2RoBgyoDNRjnkBI0oTNV03NdpYrY5lNRZCXMDwJL6iE6+Z1K4
	 AGA4b/JTBKiG8iBTIQS0ZSfSuxU3O0+YyoDmNF10=
Date: Wed, 22 Nov 2023 21:52:17 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: stable@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231122-striped-enlightened-falcon-bd4599@nitro>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to the new vger infrastructure. No action is
required on your part and there should be no change in how you interact with
this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K

