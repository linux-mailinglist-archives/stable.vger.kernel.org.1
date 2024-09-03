Return-Path: <stable+bounces-72790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C2C9699BD
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90281F23386
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50121AD253;
	Tue,  3 Sep 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qb57dMq6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F5B1AB6E7;
	Tue,  3 Sep 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358096; cv=none; b=YkJdl7Wgozqut6GiVEURlwLzGCW9spcDJMWV3iduqCdX2HuN4CI91RYQUHdu8VX/qKu5CYpkZzCz/rj72E5Gjw+smOhPpguD0Cq872KcYp9qDriw/353d5cEe3dyoDIcr+gMO6eXzfH2x3sUDysSN0ybUmaVdz2FX3i13SQ1wRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358096; c=relaxed/simple;
	bh=XVlqoNT9wzb2Amxh7yUAxG9bJVYvIwjxCkhOBEAw9AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cka7Hisqlyc8a8JOahgZ9Ohn5YxMDOaDggwsCi/iU8/mF/mr5IKo3JB5EI4AGm9tMsanA7oIYU1FmFYezf0DgtmPVxtI7sjCmgSMFS4i5/UZQZq5ruATaz1qey2Trla0pZAQbvkfeXpXTUHzFmctYCKOUAOSjGyUu7j2vNXMlH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qb57dMq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DE9C4CEC5;
	Tue,  3 Sep 2024 10:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725358096;
	bh=XVlqoNT9wzb2Amxh7yUAxG9bJVYvIwjxCkhOBEAw9AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qb57dMq61Tu7I+jvzqXbdQIHJ7vCAk5CyFz0CnPzQcLISXeXgb5gFL45pMrSoh534
	 8XkQxQZ9dZ/NMHHrNuPytOZXCOdOHCICBidZYZizv9+3cgrizFUyxTZ2KuTqPy2SLX
	 8RC9TZ3Fw5WHrWvHfQcU8OWRvD/SQ9igMBzSjUzH0nFInQwA6g4S1dwamGibpIt65s
	 fs7CfoJ/enmotox9yfoyC6h9Ebqdja0yiXkx7V6weos0yIFz+cmajR0P8iXx7+n/Et
	 bTp6Auh1Xdrf6w6T1WIOdK8/khSjsq46zJXwyusfVjczkep/itr8Xb+vtiPuCHR4bw
	 0wieIAXc+CAkA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.6.y 0/4] Backport of "selftests: mptcp: join: test for flush/re-add endpoints" and more
Date: Tue,  3 Sep 2024 12:08:08 +0200
Message-ID: <20240903100807.3365691-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082617-capture-unbolted-5880@gregkh>
References: <2024082617-capture-unbolted-5880@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=matttbe@kernel.org; h=from:subject; bh=XVlqoNT9wzb2Amxh7yUAxG9bJVYvIwjxCkhOBEAw9AM=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uAHTH/7sKrn8GI3Fo0K4MQT+i7ZYStKpft/Q l6FGjGDOpiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbgBwAKCRD2t4JPQmmg cz6FD/9fexJtn1a43BjgGJllKq77y4LZlwldoet+QKIsA8PfmQQhvuEpHdN987Inh6w+s0IwJhG f3hTG/nFIwdS3hianusZu8S44Pu6F0n+4fCRl469gqIhJPDQpjYFyZ8/60OHkqJQ+fTaYsj2mvA 4RXkB/onDpBjUBrtvYeZoDwLxtwZO4SyAUNkVpxcjuJxxMhYZ1g9hiU9mCcI3yf7Sdl/+IUM4hW bDYWBsDDab+PigfdiLtsKHeiwxnMhK2knAekDlGiRfwLUOWSi29c/5J/EeB4E0m4H8XZJ46qCbr sWDrbJJqee3R8LhvmyM9wD5bUR9bEwmO0vOe3c8r5l6f3AzQw8k7t8DGbvnfbfyY8oetrhHLHdN TTcf4nM9pAYfHS6W5kgVZn/LuZy1LK/ZUeHMi6Ef5rhkVMBaERyCCWb/NcJpFC9zo8MfVWGKoVc 0IoSlQ2m8QGUTHHAs8Bp97/hmJfTWDOuyRURj/fpcw62PorZmR0CWqcBXvNieyv/t2+UQubFPzJ HdtSOzXAdNWR+fqXP9BpPqou7K8eERAnBNjROCAeiSPJ5zxYfegpfx2Inca/NVMEX2n//qo42Wh gn6TBoX/3XE2TUipI6Gz4zOn+4Gcjd1XtnKzGLM4miq8redktEGs6pHKc+GiyWXZsebH2ImPDqi b7XzAmVOBoceGHQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

A few patches that have recently failed to be backported in v6.6 depend
on b5e2fb832f48 ("selftests: mptcp: add explicit test case for 
remove/readd"), which can be backported without issue, and makes sense
to be backported as it was validating 4b317e0eb287 ("mptcp: fix NL PM 
announced address accounting") that has been backported in v6.6 as well.

So this series includes the dependence, and 3 patches that have failed 
to be backported recently.

If you prefer, feel free to backport these 4 commits to v6.6:

  b5e2fb832f48 e06959e9eebd a13d5aad4dd9 1c2326fcae4f

Details:

- b5e2fb832f48 ("selftests: mptcp: add explicit test case for remove/readd")
- e06959e9eebd ("selftests: mptcp: join: test for flush/re-add endpoints")
- a13d5aad4dd9 ("selftests: mptcp: join: check re-using ID of unused ADD_ADDR")
- 1c2326fcae4f ("selftests: mptcp: join: check re-adding init endp with != id")

Matthieu Baerts (NGI0) (3):
  selftests: mptcp: join: test for flush/re-add endpoints
  selftests: mptcp: join: check re-using ID of unused ADD_ADDR
  selftests: mptcp: join: check re-adding init endp with != id

Paolo Abeni (1):
  selftests: mptcp: add explicit test case for remove/readd

 .../testing/selftests/net/mptcp/mptcp_join.sh | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

-- 
2.45.2


