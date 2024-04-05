Return-Path: <stable+bounces-36128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592F689A167
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6871F24CC4
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 15:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF2216FF5F;
	Fri,  5 Apr 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toIBjJ3f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53216F912;
	Fri,  5 Apr 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331433; cv=none; b=ufIp/yFK13yTOcVefB03fSDoicpYvvk/CMHNCwfSQjV1Mt/Q9AVH37tl4PEWjcbXB6FkErHT9WFt2c4CY77KJRKvmfs7AJ18uRRXA88P6JeBIw9Bz3w0i2/XuZjVXiFctPXfRTMJbE2TNrUJu5dNuYebiZf1CYthgOzswlz1KmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331433; c=relaxed/simple;
	bh=s1Oex0kNrTIW9Nx4rNY0mSFcq4dA/TCBfQzkfTD2rKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sg3aCW52WdWLC22nUOWoeC40yo8/p8j1RLy7rige4ObRGQQahPkPSodCWbqMEXyNZp4X04UyKTtuweXoXA2bh2kLtb/VDhckhTFzflJox976RIGtVgLAwcmNIfvjWDuprl9yEcwDxA7c3WuiMflc9d6hIixHOcbucqOm5YTb7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toIBjJ3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66196C433C7;
	Fri,  5 Apr 2024 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712331432;
	bh=s1Oex0kNrTIW9Nx4rNY0mSFcq4dA/TCBfQzkfTD2rKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=toIBjJ3fWyYn3HXGzTWLBBs5WWvOkWxfdwUvtwZWT3ARM15K8Pskwhj7W/CJlzIBl
	 r/R30bKErl5TSzAcQGkO31PBpSsRnZrStBhie+bigPLM69eW2am+NiZPcJENS3x3hf
	 y3KcYNL5hSmnfIBMKtMRitP7aGRHSva+JPFliNJca1KFAInAxRCFy7yvMfr5SBiDCs
	 pzViSbW4d2O7svEpwmXRzmYuN3dJ7M6h0SYzyoXOD5sF2dmlRA1KoTMzRqNhdL8gnr
	 h48I3LhEvSzEc+toIcV8VBMr7EGVC1Ikm9deuqclh6ZBTZeU3soUC4Dn60ZZe29tML
	 LsjtY0O1tFa8g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.6.y 0/5] Backport "mptcp: don't account accept() of non-MPC client as fallback to TCP"
Date: Fri,  5 Apr 2024 17:36:37 +0200
Message-ID: <20240405153636.958019-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040520-unselect-antitrust-a41b@gregkh>
References: <2024040520-unselect-antitrust-a41b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1500; i=matttbe@kernel.org; h=from:subject; bh=s1Oex0kNrTIW9Nx4rNY0mSFcq4dA/TCBfQzkfTD2rKs=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmEBqE6V5Tt3ZG5vd6nb44ZxvbPkvVPZ0sX3ANk glysbScIqGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhAahAAKCRD2t4JPQmmg c0iKEAC6g+XCg5y7NxDrwMQPf0SCfY4KZL06KfremSyDYz7bAH8x+7aPm3A5YSHFM0PurY8vRKA /ybvhxxXxx8x6aNpFUT+jTTMa2BcAz78gayKa7WssGBd44C6RAQ9WGHmYd/fA9ybFNs+5woBRGI qo78mNNTKARbksGG+FjnJRKrM7QoqR6S2H9ttec2t4fK4GVJK40T83uiw3977gOqVvRc6YjuR9g OOlzAMQxw6awUWNkWSE1pDZedO7VMCwurMYc33nCI6MmInKz0fyIfcm0EY2ZDs9BggCC2MLF1Hy 0WlzzAzmTN7crdx9vudYEOubHQM3BE/Z72c7YQpBYX7ss7zHVd0OYN782WQ7Gca5kxmNrUFjarS ASy5LcpqKjby/IBQNkLt5Jj0LzE/Eoh5mcRctcbR7oVy01eougVHaKTjI3LoXsJ64Brk0398NEN U/iOUdpUZEw0Um1nNfOKX0dduZjbz64Yu5zq4IIBjKBF7dTuQ7xJqtDah68NxOrQ7EfNgWDacm2 hNqd6HNl/huLhxuE4Wl2JoKYpoQr9vLgsH4nsIgnuxtJupl3EddSKWGMLHYbGpIORbdwcqCGiNo jxbZS9TZUImxRBCwVG3+psqpxR6lXvxyTMMrwIMT/7cx9vF9hT29iChQ/lll85EC5Oq7Bx4XP1J K9MFPdTOhzEwGmA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Commit 7a1b3490f47e ("mptcp: don't account accept() of non-MPC client as
fallback to TCP") does not apply to the 6.8-stable tree. That's because
there are some conflicts with recent refactoring done in the selftests
and around the 'accept()' code:

- commit 629b35a225b0 ("selftests: mptcp: display simult in extra_msg")
- commit e3aae1098f10 ("selftests: mptcp: connect: fix shellcheck warnings")
- commit e7c42bf4d320 ("selftests: mptcp: use += operator to append strings"
- commit 8e2b8a9fa512 ("mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()")

These 4 patches look harmless, probably safer and easier to backport
them, than diverging even more from the development branch.

Note that applied in this order, all these 5 patches have been
backported without conflicts. Tests are still OK.

Davide Caratti (2):
  mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()
  mptcp: don't account accept() of non-MPC client as fallback to TCP

Geliang Tang (2):
  selftests: mptcp: display simult in extra_msg
  selftests: mptcp: use += operator to append strings

Matthieu Baerts (NGI0) (1):
  selftests: mptcp: connect: fix shellcheck warnings

 net/mptcp/protocol.c                          | 106 ++++++--------
 net/mptcp/subflow.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.sh      | 134 +++++++++++-------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  33 +++--
 4 files changed, 144 insertions(+), 131 deletions(-)

-- 
2.43.0


