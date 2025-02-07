Return-Path: <stable+bounces-114339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A45AA2D104
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863A73AA5F4
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732C61C6FE6;
	Fri,  7 Feb 2025 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV6WrpuE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EC51AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968687; cv=none; b=hx2xGSCZosXNYcS4BhmSPLxE70TcZVM87MQW5mR7vjpqJZzFyThkA511CyyWSfeE8TNEB2gwyLxm/1ZTH3jsDNGZyBISOapzbi5s0+bLe9HJ0kYE+Nn5XJr56XuGmUfbL9bTnei8EfVo8CwDi/tJCtypVN6F5vBiSg38wC5TUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968687; c=relaxed/simple;
	bh=mu/RABbVgy01V76O0fmhsn5Tt1jitD38F+QjQ2ZK8hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RMATnejft1oQpRIZz2jQjzsHF0FnvKHdl7Npc6fy+xFPxJ4nHcBG3BJVLPzEvAwP1DCimoTF1Vd9Ue53ZWnQI1NZXkVLcifgZUq3xUxscQg6X6yeBIzdJg6G6M67cFYC/L8T4pI31h1DXCJ4hq4HxUUa4qgT6dkJxVMam12o4W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV6WrpuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CD9C4CED1;
	Fri,  7 Feb 2025 22:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968687;
	bh=mu/RABbVgy01V76O0fmhsn5Tt1jitD38F+QjQ2ZK8hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DV6WrpuEoN2FHIlayz222wjWsNlIrY4E5fkyhhUwlTTZiF8o4Ytm/3LV3iUm5yt7l
	 Y552nEU6x2mWFSRU5oOQfXT5gm61PywsYZL+Z4RGMgzWUTbdxE3DAIAPoohykQVGYb
	 zmwUjyNytdQ/b6xxoqlogTKkFYoc7f1t4e48YEGuFYj8XR38+uESJtuyb3iiScysdd
	 zmwmj8iPCirE/V+eRfru0BgVlS4qAX7ae1+qfBDybY4cdfjS6RBk63VqybpfG2wA4D
	 dXF3LXsvzH3DIYNthTlwOuVmBZd3d1zy/kDXgs0J/HNdAM2s2gz5ne9uNqKCS5qhlf
	 po3lVCFevpi8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <koichiro.den@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 1/2] Revert "btrfs: avoid monopolizing a core when activating a swap file"
Date: Fri,  7 Feb 2025 17:51:25 -0500
Message-Id: <20250207170144-29f6da02f19db05f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250206161825.1386953-1-koichiro.den@canonical.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.4.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

