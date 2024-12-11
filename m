Return-Path: <stable+bounces-100652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F0F9ED1DD
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E4318836C2
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8DE1B6CF3;
	Wed, 11 Dec 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3ZxCZoS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023938DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934748; cv=none; b=ehGnQGY79M/F08+l3KWgvnI0zGOSSNA0VnnP/+W38dYeh2LrRxjtyMGMDdqUMAofCnmpff2S2LAP6xJahMJF1jvkbG5jpKRrHJyKRB9q/t6PApi5W5XbblnWKR1GpysNlINsCXM7kEWdl4tZjMj4LUA23EpejxEbrjUmw/pfJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934748; c=relaxed/simple;
	bh=x0a0h2mg/NQjKa7WwDImuH1SPrmVbWQWouMe7TNR1qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ru8KzMH3C+5DOTojFgJObcMUiI2HdLfmP58F0+jPZh0dq4WEsOfUE+F7b44LAROFTsfKqUNrQzD9tdk2x+eR5gtHar9o2+vY9IESgrq12ZXLF7OIxKhhUYqxZ5XfF3PnxZmyQROXjZDxpxvwAlaOuJJxlMccj6pTWUbLZ2oyJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3ZxCZoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A414C4CED7;
	Wed, 11 Dec 2024 16:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934747;
	bh=x0a0h2mg/NQjKa7WwDImuH1SPrmVbWQWouMe7TNR1qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3ZxCZoSgp3XSq54RhQwxAZAasY6ki1Bj/iexz1Juhyz2Pg0wxvtu5whf4wqhCGvj
	 vgt0WnmZNEqb/xqueZVHXBTKefBHzb1FAJQJ2l3FtegksptjIfcxWLt16jVmVBup+l
	 UrJSMMoXBbvLaqYUXiBME/roBHEsZyJrAXpzElImgnxW/kxDXMBet4ig0lha7t0/CE
	 a+R49eQNRaAC0DnSGNTW4V5Czf25ZFSTkqSBfY08yJlo2C83aGL4l1T99wmK0Zlx/z
	 fQ3eS4yy0PMhc/n4LH9QZI1TuPE020PKSZ0r39+IhoVKAY9Ldn+Umm3SZ1ov6y5nyJ
	 QoFyxZOKbP0fQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guocai.he.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix uaf in l2cap_connect
Date: Wed, 11 Dec 2024 11:32:25 -0500
Message-ID: <20241211095417-a156e3300ff3a5e3@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211025407.2948241-1-guocai.he.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 333b4fd11e89b29c84c269123f871883a30be586

WARNING: Author mismatch between patch and upstream commit:
Backport author: guocai.he.cn@windriver.com
Commit author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

