Return-Path: <stable+bounces-36117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD189A02E
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FD51F21AC0
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69B16F27F;
	Fri,  5 Apr 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaJXYfPS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0916D9B3;
	Fri,  5 Apr 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328695; cv=none; b=TonOBERQeATF8N0LtzLQJ7Jv7uwny2+11gvt82wsQBSQUIdTYnrDIudsdTViCLKsCvPnxsGqJcF30WSery3961svAgOKoMgNooobNS26jpfUEThYsb0DFNLr83HysYjGay1BHZOVKcR9ciI65Fjkp5WE8XX2DiGd0drUX4lkDzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328695; c=relaxed/simple;
	bh=cxjyClOaBa2+241XYJeZc2XNLxkjlM5DuQuJWkSvQIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGKyyWBgOZWumJFuDwH45sIYxW6rwljdbcT6LQ4yTBN457ZQVUZ8eCsdebEcs5JMqtO55IpHozQpPZY1JlnmqbdUdLNLpZjU+TXRlZpsaNkBX43S1niRBeRsL8S9w7rd00cuQoKQ/zqXeocNGgeLrTFyknHJ1snMkaN9lpmkfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaJXYfPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EA6C433C7;
	Fri,  5 Apr 2024 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712328695;
	bh=cxjyClOaBa2+241XYJeZc2XNLxkjlM5DuQuJWkSvQIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CaJXYfPSKi18JjMj5AlBOZYWu8VwZ6jcrnIvhcSsmpVOEVX85goDYCk4GBcy5k3eR
	 o09j2Bbu8aDq1drWjqyAs9cP+GFg1QlV4FwX3+9njrtOA3LWlPYbh1gjj2A2x1T5Ry
	 3YYSVjUAF7YeVyMEXYjra1x+frMTll64XzkZKloZJ7GJeRSmjraa9JuMHW/H6nca3B
	 FYRBJDwxbOxqmabF6So/Azse1o+AT1PLhebBIfSorEif24dJQSeHBOFyzBkN9ziq+6
	 TqSBwytAB713PYtvVcgf+AHkvuqncIRNRa5yAPMhHFIhJ/WJ++i8CsKOHG37/beZ8n
	 NKzUHtCKlvpBA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.8.y 0/3] Backport "mptcp: don't account accept() of non-MPC client as fallback to TCP"
Date: Fri,  5 Apr 2024 16:51:18 +0200
Message-ID: <20240405145117.854766-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040519-palpable-barrel-9103@gregkh>
References: <2024040519-palpable-barrel-9103@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=matttbe@kernel.org; h=from:subject; bh=cxjyClOaBa2+241XYJeZc2XNLxkjlM5DuQuJWkSvQIs=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmEA/l3O3EAtD2zNONO0EPXNtS4a+5oonLde9zw O2Bmx8c0g6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhAP5QAKCRD2t4JPQmmg c6swEADm1+YlT4ZlGdg2BCZeW3cqxYLB2HPDms9P+/lYCmTwc+k0QucmLBk0LsHyxDWJunvJQE8 wcPTbu6q9XxwqL/KEYoeudpnVFmbJ9Zi7XKh4ShmnIXXchIGIGpGYMWMSb7xijv2/sFoN73z84J QyFtzlzNC7llpzMjkToZ5r5CstZxGxyO9ZMnRyHqx5yUR4YXwSiOoOtkMmuVpd+x1WsKiugxXrZ jIKKqH+lb8gfLkZWmIMZBSfWZx+iA6mwOUtzJ8ZG8aQ2FHrronCYWxTiLeIe+zmcuw19rIGM3EM 3VEIXNyO0iff0+wUiX03GSCKPSw1rT2soUtHWWAFxXZkLPCNxC6lFRn/4akaiUZ5UnOHQuT0g0F hFvzEGg7E2ygr1z2vCW8fi6MQ8DZfvjMPECPmaV6aKTgD5Kx9n1M23GUSOLNafTe61ahmyRqAyH USEIauDl+F+pyW7XSa1ePsWcWEANv6SDwUiPU+rQGs1LK5zyKZv/GrblVnHM9T0BDoRPBvxDSQk 0633MrZ4FvElttrleduR/HHYNY2FiOBSdFJ1bVetzYLIBtexNCvP2fqxbXX4xRF5mdh8M0ZCRIg NG/56l706dflFUiynQ5+y7hF5RnBhT4NZ8HJoe5tRLQjSFcinRgpmP0o4cWadxKKp+IYUMsngwg oJg9qMRCbY1JxBQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Commit 7a1b3490f47e ("mptcp: don't account accept() of non-MPC client as 
fallback to TCP") does not apply to the 6.8-stable tree. That's because 
there are some conflicts with recent refactoring done in the selftests:

- commit e3aae1098f10 ("selftests: mptcp: connect: fix shellcheck warnings")
- commit e7c42bf4d320 ("selftests: mptcp: use += operator to append strings")

These two patches look harmless, probably safer and easier to backport
them, than diverging even more from the development branch.

Note that all these three commits have been backported without 
conflicts.

Davide Caratti (1):
  mptcp: don't account accept() of non-MPC client as fallback to TCP

Geliang Tang (1):
  selftests: mptcp: use += operator to append strings

Matthieu Baerts (NGI0) (1):
  selftests: mptcp: connect: fix shellcheck warnings

 net/mptcp/protocol.c                          |   2 -
 net/mptcp/subflow.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.sh      | 134 +++++++++++-------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  30 ++--
 4 files changed, 99 insertions(+), 69 deletions(-)

-- 
2.43.0


