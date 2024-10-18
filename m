Return-Path: <stable+bounces-86856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E459A4308
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECB6B21179
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941C2201277;
	Fri, 18 Oct 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTxy+OQQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4638F165EFC;
	Fri, 18 Oct 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267062; cv=none; b=ZyrnIeh6TjNJqg477Bi7AtypROaxqB2nZtkmai/7y5iBlev/kZHfx9fCsvwdp47QFgGRFkk7bA9o+tiOwtDSL1O4W6xctMEJ9f9WEz9TIvBE1jLV/82g4BVy/cPEOxbQAaN8LRgtMc+9j6+2AqY7dYOVvyo1QMBsEkOSFweaCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267062; c=relaxed/simple;
	bh=ajmqCMlHuJYYxNjhywc/20ttRQUBzwvZ6/6oC762Kqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cc97KMN8epgkqYsGujhWtCexXF5E/nWcMtbw0ACbMeUZKpB6uBhfaTG8WhBKxXC7h71MNEap93RScqgu+AXEgwAdjDqWqEAuR3lHY4U6rDfKsZgXpA7c9cEbtEFBdsQyPfF7m9aVzEt26DIDweSwVwRYei3NYwriTujgGFufG1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTxy+OQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D51C4CEC3;
	Fri, 18 Oct 2024 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267061;
	bh=ajmqCMlHuJYYxNjhywc/20ttRQUBzwvZ6/6oC762Kqw=;
	h=From:To:Cc:Subject:Date:From;
	b=hTxy+OQQA3hFBl/d9GCgpXpEbIVDYu7zwJmzQ+St1Ldu7jKbLMGYv1KLOtwbFu9Zz
	 3y6ew9mygVWM0IvKEv7oZJk5GlFb/09qr7vFxR1dAqYM1I14VvbqE/7KunvQRNmWY4
	 13W3jGD2+n+mFscarfYdtTkibVdIADXl1E21P7LrdLASiDMfw1QnH31oacgIga6koc
	 n7WBvZv0DJOXCBJFjDAnMoBUKdoYmwjoGocHYg6wF+YuBA4XtywrxvY4cbuRj+91Uj
	 sV97xC+8riWaSBA7xGnIg/GCQbDYHRFcLBUOUCXEgp6Tgs7NUyHIlLxRkQtegaDX5N
	 dYnYZLY6iai+A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.6.y 0/4] mptcp: fix recent failed backports
Date: Fri, 18 Oct 2024 17:57:35 +0200
Message-ID: <20241018155734.2548697-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=matttbe@kernel.org; h=from:subject; bh=ajmqCMlHuJYYxNjhywc/20ttRQUBzwvZ6/6oC762Kqw=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnEoVuId517byOhTsqn0PrTUOpcaF+4B+f31qlk fj1yR+QIveJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxKFbgAKCRD2t4JPQmmg c1oyEADZVuefWD/5Gog6pfFiUgK3e9Z68OoyXkpy8HRAdqm/w66M5vN432DMxOKry6cAgi7FT6G NuP25RRS6/gqWL5gu+swRZrfuJSgfLgOkhAHSg+rVeT2FQjgoRLRRqTtPi2a8S7s9qoQGatCP0T 7cEQi7/to1X3y1Bz+HnDoSqFno6K6WCGSIakNbyaSy5nAl+MQ5pIsMclatGviO4z++Mn5HepirD XfgzEZD4UAlliXeILKQR3ZeGY4+cQii+0OVjLGHtDneqkIf/ixIw/anvkgWbj78O2FI0sL2hTJY lxODNht6c7vcftqJU9oS+1oU5JkyT1AJT+JVev0Y8O1691FTd9STFnzE05OFUecfcTplRSeRxjf 8F73y5h6D3jNBEyWoKgu5gGDDFiJo5pn6+CIcwGhdvfHo/iNdY8AniscSC8bZgxPUPX1YfmBLjV LwPYygfucB9+/N02AqE2FKybHrrYmAMZGqOLLxhTfQ6HICR96phB6Ie8N0PjNIdsO+CnDirWlvy H4Wy97bKsWGeFErB8l1dJymw/9ixGRV83dprXDqaRr4kJ8Lhjh//YUhb3M/uSxgADYbI/OKtjIw lDni6DII/Swn5t0Yl4sgAGidTmf0iaFBZWG2yXqWUeMy2lf/AkvPWN6M7giRUe3kH0Yu+IIsBTi cIGhHTFaXJL7/pg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported 2 patches that could not be applied without
conflict in v6.6:

 - 4dabcdf58121 ("tcp: fix mptcp DSS corruption due to large pmtu xmit")
 - 5afca7e996c4 ("selftests: mptcp: join: test for prohibited MPC to
   port-based endp")

Conflicts have been resolved, and documented in each patch.

Note that there are two extra patches:

 - 8c6f6b4bb53a ("selftests: mptcp: join: change capture/checksum as
   bool"): to avoid some conflicts
 - "selftests: mptcp: remove duplicated variables": a dedicated patch 
   for v6.6, to fix some previous backport issues.

Geliang Tang (1):
  selftests: mptcp: join: change capture/checksum as bool

Matthieu Baerts (NGI0) (1):
  selftests: mptcp: remove duplicated variables

Paolo Abeni (2):
  tcp: fix mptcp DSS corruption due to large pmtu xmit
  selftests: mptcp: join: test for prohibited MPC to port-based endp

 net/ipv4/tcp_output.c                         |   4 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 135 ++++++++++++------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  11 --
 3 files changed, 96 insertions(+), 54 deletions(-)

-- 
2.45.2


