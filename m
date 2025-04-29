Return-Path: <stable+bounces-137064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B2AA0C0A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680EB1B653EE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7F42C375D;
	Tue, 29 Apr 2025 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1gcKbah"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD8A2C3759
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745930967; cv=none; b=pi7JKedOXPPNeWqTSrQhknS7Nrw4vp9OwJJvBc4gpZyg45XEZr2dWhgZ/GlEp8r2XTP2JABvsUtVGdYfZ81E5FKOEhz4RfS+MKDmNh9vXoVYdCRpAh8xA2e8qnpUr6DqOHJeNldIa7dKZIZnF0QGqlchoJceMxg4yZG35acHQpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745930967; c=relaxed/simple;
	bh=ofAjwtxJJ90hiXxaQO0TYvFGJ/CtVPmOp0RxlxCZStA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bkq1QFO6mgtBLnRda3fXcw5lGs3nI+YFjdGMTpa8el64EmW6cGON1e6kpUNYbDTYJz8j6jUmOHZWlTOkbYhYke8k+b6pw6tECzcF+OVwcx0A8/bBTsEMZZr8A5mXj0qdZv+O3jk/HS6xvnUXe7sMZSYvfXoN++d1z2cmTEkXoM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1gcKbah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30866C4CEED;
	Tue, 29 Apr 2025 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745930967;
	bh=ofAjwtxJJ90hiXxaQO0TYvFGJ/CtVPmOp0RxlxCZStA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h1gcKbah/ECHbjZKKbKJgimC36x6jWuUCBmKFDHS+C8U0Zro9U6Z3UaZE/YlVwXhT
	 fb6///fnYjL7NkquWYmMwmcNKn8HV/vSNgOnholY69Gc4BE0SJ4A/azzkaIcrCLxTa
	 +IxT704Ae1fP33OgExACX4NcSWQXBd1X9OBAIa9dPTLdrN5IPfsVvLBmkMtSfgrcNr
	 rrRv+X5A0vFov03bpgwYVB9G2tdKScUCqMLsEooVTB/wRREdUnpOax4IPG7bjOUIDb
	 wvB9XjLMsyTKeQpVHLZyqQaNRD89am9vHcje968q/2Vz7cgTOq3lq4X4MVhgwEY9pz
	 1kpPIXdrdPrmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kabel@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 1/5] Revert "net: dsa: mv88e6xxx: fix internal PHYs for 6320 family"
Date: Tue, 29 Apr 2025 08:49:24 -0400
Message-Id: <20250428215916-425010d71c95e030@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428075813.530-1-kabel@kernel.org>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

