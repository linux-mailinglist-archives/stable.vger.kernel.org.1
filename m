Return-Path: <stable+bounces-86872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5039A44CF
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 19:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A422B284579
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0AB204021;
	Fri, 18 Oct 2024 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6V+JTS7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2DD20262E;
	Fri, 18 Oct 2024 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273021; cv=none; b=epGoomyBTqKDllTp1l0kMoq0CgqKaSvElS5hZFhnlAxwJX6rp44bQyxLBWoCKfcjUQm3YoFWHzhmCpLhc5+9WoOOzz2+NhcThzGKjuu/mgy75SdvaKC6XCyNP/zx1QZogtHfDDofhXjCs1NDeTZ5z6/F617VhyZE9f38/ssvTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273021; c=relaxed/simple;
	bh=dkvVr0qWHVvuwnN/A9baF1GIcKx7GghDGp8kvxXMKOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3jZQlErfBUchBbEJ4DPO+4JM/iZF+h9nuCuYqvdYP3SHjZPONK0r8JQbQRduIOlyoPl44Hm0YaYHptERXe6MiWiyU3K31QxqS96sgleJnTS8MO0/fkim78BkN5+qMfO20M1ZctclElsEJFWxpEm2usQvxsx02XuQBjepohCusc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6V+JTS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323D7C4CEC5;
	Fri, 18 Oct 2024 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273021;
	bh=dkvVr0qWHVvuwnN/A9baF1GIcKx7GghDGp8kvxXMKOA=;
	h=From:To:Cc:Subject:Date:From;
	b=j6V+JTS7CGv7sW/FTH6ZCnMZjKFr+xuWtuf7QbkX/OSIthYyz8wlQZdf8cG+lMi7G
	 4yPjDzzDuWFaKH/17SWEOISYWTOVUU4QMkDzQM8gItklsVkI7OMZZ7dIc5rzp6p7Dg
	 xPDbTJgkLbq9CS8jjb2Wol7oJnL2WTp0a6nplVFQIhWzg/bo8ufie3RqEHV3nUqmNA
	 sWxvxEKL9RHV3EpAvygnyV6Bwb4lEQxDWOJGTHmPIpel2LAI+10hArVLeZ+WysYBQ1
	 SLp3qyPycGyoOuhNkPOrgzZGFRgfSONmLMPvRazy4UXkJT0HzyyxbU7yvifuf5dZcI
	 WCcoe/u/hwj7Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.1.y 0/2] mptcp: fix recent failed backports
Date: Fri, 18 Oct 2024 19:36:57 +0200
Message-ID: <20241018173656.2813913-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=matttbe@kernel.org; h=from:subject; bh=dkvVr0qWHVvuwnN/A9baF1GIcKx7GghDGp8kvxXMKOA=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnEpy451F/ePTMJWGgh0IqVESOrfOtdlLtVjYPH OIuygYd2sqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxKcuAAKCRD2t4JPQmmg c3c9EACJ1fzt7eTkpzphyW5m4HfLvNNryc0O3DIU27q/0RBRreFx0PRacRnWURqVyHvXGKxCdQi KMTmLOVL2C1Vn8JZrjerHrHc0E+ZZOoZnJFsSy6TsTQN+CO5zDmdMfgQlOqSLQ5mLg5Y/0jPniJ mudY/zTKOXBzEImjQKDXYcZwwYLAakSonPSoxodK20DhzcMn2GA4f/lCOYTjs8M0M3PoZdPqOsk Kh4QQ543gbyeGwaQgrQH5eyI+qGFvUSlzIoM7AX3fDHmg41nM6EkZ52yseb8D5KsejYWUl+ZXej bjzqSBZXpn/wxB6OisRuUBmBM4nPlmpTs41A3HjwX4/g9NZQ4w0Q6I4wLrPvsENrdjwnrK8+pYb cQIVHwml4mxC1vCju2emW6pRnEQYbZWWbq0iEcxjt6jqKWwc1Avi4H8OJrZTlmiKBVaaz9OX6Fz ywjVd5iOIDmXQoIlvu558xTkrNrSt7D8tLldnUU/fXiZghnTOlUzmxrpLERo8/OCkARyfiTLSAh njTa+q8K1VqGOl0Q9khYgtpl//3JG4shNnatIDpQcl9ubPP30BjkbVB3Ech5qFBlBhDQ3aaEsLe 6pmFWoGt2sqFCkjvW7g3C7shTvnzqUVfYMTaR13wKcaAvLHinz1rrlFeFvDXyIEiymNtJAC9qNF OpCVRBpeNLSZXtw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported 3 patches that could not be applied without
conflicts in v6.1:

 - 4dabcdf58121 ("tcp: fix mptcp DSS corruption due to large pmtu xmit")
 - 3d041393ea8c ("mptcp: prevent MPC handshake on port-based signal
   endpoints")
 - 5afca7e996c4 ("selftests: mptcp: join: test for prohibited MPC to
   port-based endp")

Conflicts have been resolved for the two first ones, and documented in
each patch.

The last patch has not been backported: this is an extra test for the
selftests validating the previous commit, and there are a lot of
conflicts. That's fine not to backport this test, it is still possible
to use the selftests from a newer version and run them on this older
kernel.

Paolo Abeni (2):
  tcp: fix mptcp DSS corruption due to large pmtu xmit
  mptcp: prevent MPC handshake on port-based signal endpoints

 net/ipv4/tcp_output.c  |  4 +---
 net/mptcp/mib.c        |  1 +
 net/mptcp/mib.h        |  1 +
 net/mptcp/pm_netlink.c |  1 +
 net/mptcp/protocol.h   |  1 +
 net/mptcp/subflow.c    | 11 +++++++++++
 6 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.45.2


