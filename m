Return-Path: <stable+bounces-72738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD300968CCC
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 19:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BA51F22B49
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141691AB6CB;
	Mon,  2 Sep 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3tmCYp2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E5519F112;
	Mon,  2 Sep 2024 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297925; cv=none; b=MgkhM0kPBZg3g9ZpxvnL4WaryNLx1RUHoc1Et+jttm5ahUESiMfZorQSxi52ZfFv7YcR40zc8b7TRFqnuamAWKnJuAaddW9G51A+3t5+AMzoKCFdkLTNbQLuD92yxzFDz3HGBoPVtQY9h/q1lqabFilcLCh4mhbIiCvrsugBS5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297925; c=relaxed/simple;
	bh=2eJ1pdoyFxgyFhYcLs1pco/m9bQkVEsBxssmmrtH25A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMH78/Q4n5HJS8JQo7YhSjbyxgXCW35zIuZZh09gbF9DVOjGj009MioZM+Dc2gPm22IEc1/MreOyfIxefwHl1erVb+YP4hoMoWT2sXk2bO5u4e1c6lJFMifF0J0uf5kW8AoGQnMmvtG29/uZngME5u8vCQQZq+3uCahcNX+8A3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3tmCYp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AA2C4CEC2;
	Mon,  2 Sep 2024 17:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725297924;
	bh=2eJ1pdoyFxgyFhYcLs1pco/m9bQkVEsBxssmmrtH25A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3tmCYp26+pwqEmne4koDEzl2tGqRRKrKG8bB1OmADk8wj+KauJuuIXnE8T/0CwFN
	 Qelhlhm20UWfi6Abuf/uCIjIIL1x6AkoR7egbHaj/Z9MxqXOhdbitybCHg/9fQjb/S
	 W+Z8HaOSoe4mNMQBXxSjGRUxwe1fEXVb+8D86UGkDhHzzf9WNG9fLjIwvIVOO5in8/
	 V3pfY3cueODpSJzDh6A+rfTDZEpqMfL2g4TTZ25Y5q2yxJyaL0a1rFVzEY2sODda6s
	 eaJ2Xy0+/AXT/lRX9Fy0s5lcwxvmOcqhhjkeqvmsN4NFpBi+IoY3GG1THgzlsj4B6n
	 uzQSt3CbrTfxA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.10.y 0/6] Backport of "selftests: mptcp: join: test for flush/re-add endpoints" and more
Date: Mon,  2 Sep 2024 19:25:17 +0200
Message-ID: <20240902172516.3021978-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082617-malt-arbitrary-2f17@gregkh>
References: <2024082617-malt-arbitrary-2f17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698; i=matttbe@kernel.org; h=from:subject; bh=2eJ1pdoyFxgyFhYcLs1pco/m9bQkVEsBxssmmrtH25A=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1fT8BNkbzZK1DcUmL5amG9E96aDMknkmg2HQH aDc95E0AlKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtX0/AAKCRD2t4JPQmmg c9mBD/9xbISLWMNsoW2i+73U/jKBgX4fxEUUCfynfDLPYe2YZ39hfwNcyvH/eyHd8i+dNBWEThA w6pjdo5GBGgQ+Ah2yMiv/U89+5FYrxBrjKu/tzwi0rRBz2yYk4L1j83lZyOgyGk5XqVu9MteOCn Zydzdcw7O+bKCZ/JqAOkzD5/NWdIZs57iF27pkAPrJlKj+HqeDR94f4rh+gc7EYiWvhHMLJpRbT 6oIK1ny7C8OqXp86QZTkp3hssjhc2/PEgxUeJ6xnIik8Nrzcdw7Codhs76fJDt95DNtP+8Iknzv O9tX+AEhAIs/TbWEASjSnH385GHFeB1nkZol9ClxlwNiA5QGKKxh+pHQrDufei/3oDG2y4JB8K+ oImwET771srMc2e2Q3k4xJ9jZUaFEx2tdbPzn7xsdnrJydtv7kTHrZZl7cJkUKavVWyBEhpv2Eu RlA0I0kY/o266cm7HAVqPvrFswBAgugK/XCd0TUNzTKcNOenSZY6GJLzla0kAovx1MZ4wSrvkn0 ohqn8ik0bsUPvCuFxr9oYoN/gk3zrkI0cpU0RNHJzyhMY9uL3eWWXQ/qj8zt5BiDRHld2sXw7XE tVuZ/TeOPKB3GCYU6DVrRUb2P51x0qgSD8s7rFDMghgshjKVAZGgOK3oBwyQvpRvKP0V6oBwCje Aj5oXZ6kviHSsdw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

All the patches that have recently failed to be backported in v6.10
depend on b5e2fb832f48 ("selftests: mptcp: add explicit test case for
remove/readd"), which can be backported without issue, and makes sense
to be backported as it was validating 4b317e0eb287 ("mptcp: fix NL PM
announced address accounting") that has been backported in v6.10 as
well.

So this series includes the dependence, and all the 5 patches that have
failed to be backported recently.

If you prefer, feel free to backport these 6 commits to v6.10:

  b5e2fb832f48 e06959e9eebd a13d5aad4dd9 1c2326fcae4f 20ccc7c5f7a3 f18fa2abf810

Details:

- b5e2fb832f48 ("selftests: mptcp: add explicit test case for remove/readd")
- e06959e9eebd ("selftests: mptcp: join: test for flush/re-add endpoints")
- a13d5aad4dd9 ("selftests: mptcp: join: check re-using ID of unused ADD_ADDR")
- 1c2326fcae4f ("selftests: mptcp: join: check re-adding init endp with != id")
- 20ccc7c5f7a3 ("selftests: mptcp: join: validate event numbers")
- f18fa2abf810 ("selftests: mptcp: join: check re-re-adding ID 0 signal")


Matthieu Baerts (NGI0) (5):
  selftests: mptcp: join: test for flush/re-add endpoints
  selftests: mptcp: join: check re-using ID of unused ADD_ADDR
  selftests: mptcp: join: check re-adding init endp with != id
  selftests: mptcp: join: validate event numbers
  selftests: mptcp: join: check re-re-adding ID 0 signal

Paolo Abeni (1):
  selftests: mptcp: add explicit test case for remove/readd

 .../testing/selftests/net/mptcp/mptcp_join.sh | 160 +++++++++++++++++-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |   4 +
 2 files changed, 162 insertions(+), 2 deletions(-)

-- 
2.45.2


