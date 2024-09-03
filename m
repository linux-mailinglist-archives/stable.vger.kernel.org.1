Return-Path: <stable+bounces-72803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB4969A0D
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D92B1F23D94
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4D31B9853;
	Tue,  3 Sep 2024 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb0cjCOH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B861B984F;
	Tue,  3 Sep 2024 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359034; cv=none; b=aGhrsXsstZmTCOTueAB5syVy2S63pRqQnsTaqHsC+j04fSld8769D0jZTpgQiR3zbD9X0t+z2FrddIEJ1Rqmb792yL+4vfzAFqJKzm9miEyRmPKdIvuwBNlnoJ+DMbArCraBj4GeWc1dvq9MHFjKWl+QoAfGjiIC0zbsviH1NGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359034; c=relaxed/simple;
	bh=dDdXoOQbTnV6Lw6Od1zsKDURcCbmY4/YfkYWmRlexos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmDGjg6qlxKIvnjDyQSaX/WLk21ALgnmNus7qYHLcbOsiYOfMww72K1Cm106McXoyNfwxVc7M0g1a+ug442tpHIXy6SblqPe/aAm2THp7Z7hxHkcSP7PKyZzfi7XzmkpwKciKKnjz8JtwfC5bkUV/ZCyIHG1Cc3DchfymO93diw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb0cjCOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CF6C4CEC5;
	Tue,  3 Sep 2024 10:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725359034;
	bh=dDdXoOQbTnV6Lw6Od1zsKDURcCbmY4/YfkYWmRlexos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sb0cjCOHeZudRnNceajwuuLo2yphphD5mbMDoZom6hTFoVbUf5Vz8q8Z4h1EsJYru
	 tT2J8NMpqIWx9RCHBiAsvI6slW85epZvO7mXkejXRF/wTJw77BGv0/OBYE0+bcRDWG
	 Cw02iat6cSmLWnVIPNuh6apJNcMFvx+QlZrbL4TtTX8G3Vcfn216FDkjp4INPIbQmD
	 QdZHGO63c6ClY31QhzS62vMBAZh9B5zw3FkwPpJawshSKSXug1n5Acds21x4RJnPBl
	 lhcQeIN8JtzPU38qD54GiB95Lyje7Fgr99f/3xl4vgK03fze4SVzxxds65R8RAEkFx
	 cen+OGCQphIEQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.6.y 0/3] Backport of "selftests: mptcp: join: validate event numbers" and more
Date: Tue,  3 Sep 2024 12:23:48 +0200
Message-ID: <20240903102347.3384947-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083025-ruined-stupor-4967@gregkh>
References: <2024083025-ruined-stupor-4967@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=matttbe@kernel.org; h=from:subject; bh=dDdXoOQbTnV6Lw6Od1zsKDURcCbmY4/YfkYWmRlexos=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uOztFsWm5AbIpOLrkvdnq2d91IUAQolFbYiO R3Tt8/D8eiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbjswAKCRD2t4JPQmmg cyhCD/9moDAQErAS+q5GWSyv9xmJSKFiQ2EFmvPaLMM4p99BkGPVyL5OZaRJUuGQuPj19s9OIDe /LBAMhKNeG1PatNTri6XdloUYRf3Jcg//R4qFi1ZCujZ/UP7ILBVac+L5EA+Po3YDmxfhf0O3BG h8iPTfnwO6siqg74CSYRRvV4LBG4XbwKL60A1dWSDf4VesuKX+A4f/Omu4HgnHLc8EIJyCVvQMi q8ebjD2bjCWVTXOBz6+BNlYHByhplJt78ignnnls+LZBl6sGVdC8Tdi0l66PQ69ItpftPtVnTH4 Abbsk4lR1iGmU9QrKPcxL3yRQBGhjcLKbZ4SB8KF42MUx3pvjCRfIr7GlZVEC7TTazitb1vzCdO 9c2aLPVxhDnVYnoBN8azN6uXmVBkqDDNVMX6zYurTQ1LDm20ChKDXNo0Nu1lKhwvFuz8+C6evw1 XOOnYhSySrO8VUlCg57PaL8DDsK0dKOKiDHQ6mtggZEirapKFhPX6kKFwZLURf3GSHnqV1NbhC5 Ob0xn0WkVTPQJ7N5hj1ooHS9YJKoaF/x3Q1g82eqLkim61vFM33BChEKAaiDh+cRPmZu2zV3u94 lCSV/oSDMXargbE6Z3PQ06ysN0XGZIgss12iyuSoF3sq4mf+0QrOAC1pXBa1UGSTTqn2cRIvfp/ zgaa3BJN4Dbr9nQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

To ease the inclusion of 20ccc7c5f7a3 ("selftests: mptcp: join: validate 
event numbers"), 35bc143a8514 ("selftests: mptcp: add mptcp_lib_events 
helper") sounds safe to be backported as well, even if there are some 
small conflicts, but easy to resolve.

Once resolved, f18fa2abf810 ("selftests: mptcp: join: check re-re-adding 
ID 0 signal") can be backported without any conflicts.

Geliang Tang (1):
  selftests: mptcp: add mptcp_lib_events helper

Matthieu Baerts (NGI0) (2):
  selftests: mptcp: join: validate event numbers
  selftests: mptcp: join: check re-re-adding ID 0 signal

 .../testing/selftests/net/mptcp/mptcp_join.sh | 100 +++++++++++++++---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  27 +++++
 .../selftests/net/mptcp/userspace_pm.sh       |  14 +--
 3 files changed, 117 insertions(+), 24 deletions(-)

-- 
2.45.2


