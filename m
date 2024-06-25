Return-Path: <stable+bounces-55785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0318916DF2
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD53C285586
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 16:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18FF171E41;
	Tue, 25 Jun 2024 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiKmHRG9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA8916FF23;
	Tue, 25 Jun 2024 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332564; cv=none; b=JtxMwtsdERKU8UX3XlYevHPMbzds+P+cb0VK+YlFVNi9NeoIXWBBAIuAB/rJuMZIdbSqf2cmoOgoOG9Cx54a9GQaElDNLyS7jJ0N59/xHwNhipRqlxRmlE0GMW4ALha3TKM4tjSgTXaxnIByh/4UB3oxP/BhJYKPE1fnVyJPJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332564; c=relaxed/simple;
	bh=Db2Knfe870WniTxAq795xFhyamj9Nbv2RviiIjkqvPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q87INxaefhDlRaEmqqt97XW3XZl8LrJC2xNZzxO4HxA2aIgtQhIJi0+89KOZpvf8Ldj0l7x6Ogwlo9twxr75YLqTPZCF/wU/pXZlp2TNsyfuknT5POZBUlvfXH36/eeOMe1tI1atEsZNMPSgyWkZO8oUUGH0AIB35ogKUeVMVwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiKmHRG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCDFC32781;
	Tue, 25 Jun 2024 16:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719332564;
	bh=Db2Knfe870WniTxAq795xFhyamj9Nbv2RviiIjkqvPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiKmHRG9GutKhwRyti686WU6tnIFUAZW/TYBFol9kXFEALqN59d1IWB4ktTJwmhIK
	 /+pQfckVjNbIcoQ/aCOkNOhi/EoRMmyMiv4LgF9wN/zLylyP1xD3CYTB7Vti79Wivm
	 BqlnXX6+5RC2yXSnMEBH8i64qGCWAxEOSGEfiJzPDbcZayy5gOU7Xss4EsedjlBMyJ
	 jly15Ctt3G3/An+0Fmqe6YdQGYQnniBuVRUShsEGJmimZbm+VLL1Lc4chnEvFs7+DP
	 iPMVAkx/kwFUwlHhPkmWL8tbpFcee1zrbgljlT6whm5YKdp63kdq1rNIJr8rgCS8+9
	 2bjxt1bScyP0w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.6.y 0/2] Backport of "selftests: mptcp: userspace_pm: fixed subtest names"
Date: Tue, 25 Jun 2024 18:22:10 +0200
Message-ID: <20240625162209.3025306-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024062405-railway-unpack-e903@gregkh>
References: <2024062405-railway-unpack-e903@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=805; i=matttbe@kernel.org; h=from:subject; bh=Db2Knfe870WniTxAq795xFhyamj9Nbv2RviiIjkqvPM=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmeu6xq0zEnek5JBdxhJvMAT6Q1v6xxKRqIVZMR sT8PfPXYdWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZnrusQAKCRD2t4JPQmmg c8m7D/0fDmdc8r9cdH0/27bBpLIql5bqXg9gKYTaSNVzYcXpYVZndC8u0oiONz6wS45l19AngGu xHEnLLa7Kcc6Vb3fSoUB1z2tT5GMEpFqhLoZtU7XrR9vQxLKsMve2Cfl4Ty66ZnnnehG3FaJOan WdXjzg9zQDBCDVN39IStgJGrEqw4ti5/c+jTs0WkL6QN2vzplfqkrERwb+uGbAhwpRWqoUR2avl wx9tSkqUjGg9qrah36IAUxRmX8yoELT0Y4N0+t0rYC/07WzKvIbu/I0vLeS1iReQxAbYIIVjWXF 9eHGzeb9HuPQXasMW2B1OspD5XHmncBFmGMWo8h/nIYcMo1VacSEPXuNtZly93QhYnsBNYcn3L4 u4M1R7pYqtLU1ykH43/7K6tVxE4NXKoCDwe3L4rPJlsN5KvaJoX9wmCuqyaxmBfJ5t7/BMLus41 QCyvhJKOM5iYxjrZP8BHo67TosRyy7VJMakEUtqUoKmER3gXwkHgAHabZuuY+0rf+L5Qphp77+x szaKm317PF6Sd34ylYd4MFmUeAR2jFjBa1Xex7Ri3Z+9QT2vWdfgy1AMVOBBIwW4Mfa9wk7sNNX +bQbDHh2Mg/EzpiSY+9YcSoMRiodbIgFRu6cJP+/H7RUxw0t/Bz72rhXjfA7erYeaqFqphpFnEx 1PZshOQiB7xmfbQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Commit e874557fce1b ("selftests: mptcp: userspace_pm: fixed subtest
names") could not be applied in v6.6 tree, because commit 8ebb44196585
("selftests: mptcp: print_test out of verify_listener_events") was not
in v6.6.

We can backport this dependence: it is just a refactoring moving where
the listener test names are being printed in the selftests, no
conflicts. After having applied this dependence, the commit we were
initially interested by can also be applied without conflicts.

Geliang Tang (1):
  selftests: mptcp: print_test out of verify_listener_events

Matthieu Baerts (NGI0) (1):
  selftests: mptcp: userspace_pm: fixed subtest names

 .../selftests/net/mptcp/userspace_pm.sh       | 50 +++++++++++--------
 1 file changed, 28 insertions(+), 22 deletions(-)

-- 
2.43.0


