Return-Path: <stable+bounces-105292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C0F9F7A99
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 12:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C427A38A6
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 11:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EAE223C4C;
	Thu, 19 Dec 2024 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0hIl9Pw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86F223C64;
	Thu, 19 Dec 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608745; cv=none; b=PhiMuLDJ6ITNok5HJkQWu31+eMa8h275fxz68NtGsNImPhupPrcWLPJ8mJ8lx+hGnVdpOknMP1lVgfOvghREr7P/rSwWVJMyRSBnzrf54zwADHvDZt/351HqcNBMG/bd4d2+TORSrMWhk30dTEPqepUuDiYayIJ1d2aiBDsRpvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608745; c=relaxed/simple;
	bh=L5I92xzjE+xlE2hla+sscgIGlaUc5vih+n82H4lZf7g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OmqH1E8+bycRsSxNGV8nhjjiaSs9l+qAubenKv+7aOWY7c7xlfUQQBCOeZl7ZPZ4pJaNKn9gwmVkkPzg+cth2UIeoWj0VQBbR2CYur/vDJYePdWyp9JlYrr0EmdPe0mbyNsLgTmx5y94LYBWzZBMcZNCHqqrEpQ0iGj+qmBjxfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0hIl9Pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE18C4CECE;
	Thu, 19 Dec 2024 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734608744;
	bh=L5I92xzjE+xlE2hla+sscgIGlaUc5vih+n82H4lZf7g=;
	h=From:Subject:Date:To:Cc:From;
	b=V0hIl9PwamjLKsCO3qFvXjhS/vtrhHXK2RIvPkDAPuVc8KOR4Y4m/HgnSy0yTyem2
	 Aqnho6VhxDTViQbunuaAAY0ez1P7rjgCVaATsemtIsk/O72LIQK5v0Ei8gbGeJ+okz
	 4aL2bl5w8d+puhJ5ccnf7sqOD2FVRjcyF2dvuYF9PjKfhRUSaqE9+N30Lbi9XRUFjh
	 3cpAbjkqn/IAbnQ0nynvnxVr01P9NtSfINYDnQsCACeK/Vp75SYaqTk8yzL0z0uEVK
	 AsXAbKA2nn0laLOraTZRSYPU5H8w18+HFaDkcDL6o943DH7GFUEAmeEUThk9NlYsd/
	 tFWf994iKsDvg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] netlink: specs: mptcp: fixes for some descriptions
Date: Thu, 19 Dec 2024 12:45:26 +0100
Message-Id: <20241219-net-mptcp-netlink-specs-pm-doc-fixes-v1-0-825d3b45f27b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFYHZGcC/x2M0QqCQBBFf0XmuYF2EbF+JXrY1msN5TrsiATiv
 zv1dg+XczYyVIHRtdmoYhWTuTiEU0P5lcoTLIMzxXNsQwwXLlh40iXrb32kvNkU2VgnHubMo3x
 h3IU+RfRjl/AgT2nF//DSjdyj+74fw//HensAAAA=
X-Change-ID: 20241219-net-mptcp-netlink-specs-pm-doc-fixes-618a2e8f6aeb
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Kishen Maloor <kishen.maloor@intel.com>, 
 Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=L5I92xzjE+xlE2hla+sscgIGlaUc5vih+n82H4lZf7g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZAdl4U+V32qYR7n8/pblQCq+PCzlJWpUpCSQ4
 B9nJ7ZUcMmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2QHZQAKCRD2t4JPQmmg
 c9EZEADITUi98FJ+QXIOKMI0q8HLBLBAoTuHAtMaD3cB3kEXRRIEgMgX0CUetonRlPDxz4cLJlc
 im1HF9tUqsajxGh/MXLZ5wXTK/nRW6dizFZPIAoFmyZlI34+PyAvISZ+BXSKIzFLy2EHUhzZEyc
 6QWZhpL3RSDcoYgyQzyHDQ4QR3Q5nxW8DV5BXsWwSrdMVACWTh68KbLK+Lx9mN6EeP64K0w3oxy
 I6n2cJ9gxi55VcOeq7viHo6vll8moVT8ThbCKvsj21g/oasGBddudTt23ek2dLbPXI5YhUtpfyI
 padwppFtA98o9DLkeuiBK6vUChUHx1lKoXYNijylY7fEif1w+6B/V+3YQF5n1b5pg33vgjpfLuD
 CONWPsM1OSdU9jlnoHelKKTfW3cR1IXRHytF+K5DvfK0GjLVPUxb8uBnKKVm2+8hwGd/PHVrY9O
 sQbFt6Wo9upciWXTixWJBt3SElqO7WFg1ycqREBtrhMsOhY3wlwDmDBxm3FFHn+yxjIbrAAFMLl
 dDaD7Za/NzTonsagt/OYAI/wnH0/2fDJ97bnOVDbgZCX6o43/RlbawysCkDqP+YwAHOlh9rtGzy
 RHzFe/CX/jgItmt9ATUfFdvdqPB/zp4i60r/jDxSWz5+/cNEmVHyONmr5FzZBn/INqzy21MKsZW
 18oFKdDwhYLWj2g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at the MPTCP PM Netlink specs rendered version [1], a few
small issues have been found with the descriptions, and fixed here:

- Patch 1: add a missing attribute for two events. For >= v5.19.

- Patch 2: clearly mention the attributes. For >= v6.7.

- Patch 3: fix missing descriptions and replace a wrong one. For >= v6.7.

Link: https://docs.kernel.org/networking/netlink_spec/mptcp_pm.html [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Please note that there is no urgency here: this can of course be sent to
Linus next year!

Enjoy this holiday period!

---
Matthieu Baerts (NGI0) (3):
      netlink: specs: mptcp: add missing 'server-side' attr
      netlink: specs: mptcp: clearly mention attributes
      netlink: specs: mptcp: fix missing doc

 Documentation/netlink/specs/mptcp_pm.yaml | 60 ++++++++++++++++---------------
 1 file changed, 31 insertions(+), 29 deletions(-)
---
base-commit: ce1219c3f76bb131d095e90521506d3c6ccfa086
change-id: 20241219-net-mptcp-netlink-specs-pm-doc-fixes-618a2e8f6aeb

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


