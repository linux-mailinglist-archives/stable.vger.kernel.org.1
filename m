Return-Path: <stable+bounces-25925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D22A8702E3
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1759928B25B
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 13:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05DB3F8E6;
	Mon,  4 Mar 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qk55mqTT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5143F8E4;
	Mon,  4 Mar 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559543; cv=none; b=eC/+05lLv5MVkQKr8mLEp5sGQJiFj71kKuaK3BL3NVC3XKonCLw0AfOs5OdR/YCuAvxIS+0poSn+UsFMHHfhNfNqo++7A7ECShquzyB+2xvInkUihDEgxuqUyScM0/lspXqq0plMWzNqfSQj4fmjnE8hks22A5xXjSEMC9/w/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559543; c=relaxed/simple;
	bh=yU/cjn5H5P2K62EL2dxm6k8dPn1IkIYNk7rk/fgQgBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiyEOIsOlazdmnvJSyvHN0eXXf6QW2jr1995IeHGCejmuG+Li6F6+GwS4Ag2hO55j7ZNEI0WCv18iOtF0nK/WkiPuixNnip9sQXJcVJ2LTfeCCTKwS2FCVIvwZX3FtSrUqsKq2SDZdEsmHNGob91u2xsFGrYBa8Hop07+xChAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qk55mqTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0641C433F1;
	Mon,  4 Mar 2024 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709559543;
	bh=yU/cjn5H5P2K62EL2dxm6k8dPn1IkIYNk7rk/fgQgBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qk55mqTTEaT3FOwllAmSxSD9Df8Aol8GA6SHKIrKz0uW4L+g4haetPfEub1PVje3H
	 pHYdaU/t/JzC0endtwX+9YrGm6gyuN+RHkrJHATiuYMgqlt5xXS0Xu/9YBFEoKRcME
	 mOhwiK0yomJfKqX7h2Xfdb3dbp5s3H8AXobvNjolq0PqGm5lreHe0dcxZvIOi7sBCi
	 fztjoUBvyJioXhz97+RrpYWEhvSpfo9p9KNScAU6XxexIUfbTDiQlM80B5iOwb817c
	 A4eW4OGQ72xt+1+XFXYXdNaynDmFYkAtZO6UEEjupOA148ZGYE6Sh24RBvfOBYuymn
	 mvPK2XMyGpG3g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.7.y 0/5] mptcp: dependences for "selftests: mptcp: rm subflow with v4/v4mapped addr"
Date: Mon,  4 Mar 2024 14:38:28 +0100
Message-ID: <20240304133827.1989736-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024030420-swimsuit-antacid-a0dd@gregkh>
References: <2024030420-swimsuit-antacid-a0dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=matttbe@kernel.org; h=from:subject; bh=yU/cjn5H5P2K62EL2dxm6k8dPn1IkIYNk7rk/fgQgBk=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5c7TAmjsBqWUZuEt9ECEGjPHeh++PLG9SL2xf xBoAukN3ACJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeXO0wAKCRD2t4JPQmmg c5neD/4pe5r/+sh6qEEqpOgRJxhGhlyT+WW+MzdjgmF/hGBruac4HWwkJug4OX57av9o2cmfZxQ lNPUSESxAs0Z9YbY9zkWXvM1ORIxXy2YdJ/MeGs7ZjRuLmetaH29CQ3mSHpTC7VRQnew83PNHwO IIhCGLE9suPdLdrSfVBTK9e0m5lvEVBdlyntZk8d9Q5BXAGHsFmyJQGWdRDsOXx5MGPSLrq0slj JVnjEZxif0I5JJACYwnKf4QG4obQRqH8NYvyc35k+/uIrLmKrewYZbBi2Mhd2FMAOtKOpKGHpTG Yq4fuLr1mI/MfR5Dh5iy795V7W0+xfk/m5HWCZx+zxRegnEbVvJwisDib17TsIBfWI3oRBNzJo+ q3yqAnFYGwqZQxr8yaUVAPIMp2KnagtYv946GXsCS041adU49a3s/rLoawCysQUXV3GYtSBN0O8 u1HkEIc9iZO9AbDmYgchJaNOT5FVMmoID3oZXlJIgD69eSqZfglw/EF7o33lWYYCyneNM1wAEhM ajGd09VYXyN0qQEURz3tqgYAb2hWZiH0JQTx9eLcwyZTEBU/cgTk1n/Hc/lGNzekG4wE1qQ0Xkf ZT2JND/HCDBceoithi6jX0LI+lZS4QNzou/bWWpBACoBtdXL6kwnzDdX5rbt3icia/6I+0sPNrI xfsohPR6FUwBZUA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Hi Greg,

To be able to apply the last patch without conflicts in v6.7, 4 other
clean-up patches are needed.

These patches mainly replace existing code with helpers to reduce code
duplication. It looks interesting to backport them to ease future
backports.

I had a few conflicts in mptcp_lib.sh, because some of the new helpers
have been backported recently, but not all: so I had to place them
between others.

Geliang Tang (5):
  selftests: mptcp: add evts_get_info helper
  selftests: mptcp: add chk_subflows_total helper
  selftests: mptcp: update userspace pm test helpers
  selftests: mptcp: add mptcp_lib_is_v6
  selftests: mptcp: rm subflow with v4/v4mapped addr

 .../selftests/net/mptcp/mptcp_connect.sh      |  16 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 187 ++++++++++--------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  15 ++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   8 +-
 .../selftests/net/mptcp/userspace_pm.sh       |  86 ++++----
 5 files changed, 170 insertions(+), 142 deletions(-)

-- 
2.43.0


