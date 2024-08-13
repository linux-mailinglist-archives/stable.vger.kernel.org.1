Return-Path: <stable+bounces-67436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8233950131
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997372812EC
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3318D14D42C;
	Tue, 13 Aug 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn4OPMlA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC816BE01;
	Tue, 13 Aug 2024 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541308; cv=none; b=C5JukacYhAMO+u67i5tXh3BGW9jzcnEBiK4zul0mfNqZH3Nbho0cNhQ8JVaPxGg4B+ftmGzkzNoZScfmGJ2zZZTdqlJ6GkkbJvddmaBGkWdr5fH63yqI9B3tB7VD3AMWZRQIzWqMW+HCxRTucURE9rTeBLkifhwJAtrEl1ENemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541308; c=relaxed/simple;
	bh=pMHSEavhlxYh7I9ymCxf5T6iIus84QEj6kKEpHiQ06Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3KpC2wI2XX7PvWGn38+5EGpWZ0T7rq4U66WLLBWL6/ecCkgNDSmxT834dqkjim4rp7y2ht8GzayvCQDk3CSQH4+IU7QW+au01T/HAVA8ymFpzaeKkQYYw8fZOJ9OEOsL3Bm8rX8BT6vxGYRxpfnkSGdmIdrrz7gKE+WswvHU2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn4OPMlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2D4C4AF0B;
	Tue, 13 Aug 2024 09:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723541307;
	bh=pMHSEavhlxYh7I9ymCxf5T6iIus84QEj6kKEpHiQ06Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hn4OPMlANYAo99TCQFM2/nPXkpzhqcvHUWn8h/U98azzPn36VsKuOAKHWjBlI0tIB
	 iFdtyxz8GgDLnydVJD67Ax5feM6yYV3YUhSMvLjwt8SETD2j0I1GJyW3nT+pkBscb5
	 aLIvWypU1E4Xzh8w5Sbp1UA2/a2IHuGghTOthC4l+bBhRcW2HJSxLtFrs9hItfIHQm
	 zx5ccTOYlaFvxXW4YCBh7Pr9ZB9q+Q8RzeWvcAZw9ZzgaiVdSqEpz/fUTIx36v6OWl
	 hsQ49A1gQwM6iPtyhgPmZB0J/vcukCqhA4JkxsJVJjiXoQnYjQuEGJoqJN4tCn1pfM
	 7enpSQGwprm6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.1.y 0/5] Backport of "mptcp: pm: don't try to create sf if alloc failed" and more
Date: Tue, 13 Aug 2024 11:28:16 +0200
Message-ID: <20240813092815.966749-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081245-deem-refinance-8605@gregkh>
References: <2024081245-deem-refinance-8605@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=matttbe@kernel.org; h=from:subject; bh=pMHSEavhlxYh7I9ymCxf5T6iIus84QEj6kKEpHiQ06Q=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuycv7nO/LPDJm40wFlxmxTqYN9vpBOUtgKXUa VRc1qj0nAKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrsnLwAKCRD2t4JPQmmg c935D/4w2oasAOtm2hlVxAiPSScs1xA/BqoKE3CBvB/4CjOVDoztYYUtLQIxfgs1Ziutz9KzrM0 KAM1sVGXSN6GcbItisGDB1gNle5ztwfidF9Nnet2/xkjhSBYuFpMmO5i4PusV/iBRJHblxJWUbg cqsx34Rw+6hqpT8x+7vgFOL47yLdg1hNO4vs23mYKgXGmWqmQM2ntq+mQ/GNuDa0vKnQ3LTs0bo YU8DXdJunQD1gODHeCU9cWiYR6wS6iA2VtOQ1FEKLg0qU0Vcq0+xfl+0VKuqDGCkEAXcOqbvEIR sW3p2Jn8jMbj9TtBBiGqOWVttZy3pFiL60XVIPH54wXRTAjqLtKwMfkK60ZMgzdcQVbJHkL0bY5 JeWZi9wLxnwMQ9yaqGFU2PXeZ9EJupKeLPJMQYC7uygo80bUBK1Hj7okYzeCLHTNBSFwB32UsoL RcK/rUB1tHZ0sy0NBofKjaoBaVaycRcrGsEbQaGDVpIq6+s54nHytVVeFOOskyXDS/gFAIA7L9S gZuiY7q55Kcdw5O15f6ecwpjK5VALPeQqjxR40UaHi31/8fIv/Y1yEFVHmzRZPi4iKK7Qnwo5yQ LTfnpoicNd7tq4xIRRem5LUKACoKQwVby8UpRrU+CRRUyrKHZxwk0Jf/6Y0hoPbrPOBzNRHWWcK OFQkMxBALGc+JZQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Patches "mptcp: pm: don't try to create sf if alloc failed" and "mptcp:
pm: do not ignore 'subflow' if 'signal' flag is also set" depend on
"mptcp: pm: reduce indentation blocks" which depends on "mptcp: pass
addr to mptcp_pm_alloc_anno_list". These two patches are simple ones,
doing some refactoring that can be picked to ease the backports.

Including these patches avoids conflicts with the two other patches.

While at it, also picked the modifications of the selftests to validate
the other modifications. Note that this last patch has been modified to
work on v6.1.

If you prefer, feel free to backport these 5 commits to v6.1:

  528cb5f2a1e8 c95eb32ced82 cd7c957f936f 85df533a787b 4d2868b5d191

In this order, and thanks to 528cb5f2a1e8 and c95eb32ced82, there are no
conflicts.

Details:

- 528cb5f2a1e8 ("mptcp: pass addr to mptcp_pm_alloc_anno_list")
- c95eb32ced82 ("mptcp: pm: reduce indentation blocks")
- cd7c957f936f ("mptcp: pm: don't try to create sf if alloc failed")
- 85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set")
- 4d2868b5d191 ("selftests: mptcp: join: test both signal & subflow")


Geliang Tang (1):
  mptcp: pass addr to mptcp_pm_alloc_anno_list

Matthieu Baerts (NGI0) (4):
  mptcp: pm: reduce indentation blocks
  mptcp: pm: don't try to create sf if alloc failed
  mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
  selftests: mptcp: join: test both signal & subflow

 net/mptcp/pm_netlink.c                        | 49 ++++++++++++-------
 net/mptcp/pm_userspace.c                      |  2 +-
 net/mptcp/protocol.h                          |  2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++
 4 files changed, 47 insertions(+), 20 deletions(-)

-- 
2.45.2


