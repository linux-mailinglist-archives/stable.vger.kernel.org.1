Return-Path: <stable+bounces-89697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A719BB4B0
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 13:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C9F1C21D3C
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685001EEE6;
	Mon,  4 Nov 2024 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEdqPRHf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8E3469D;
	Mon,  4 Nov 2024 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730723519; cv=none; b=mrPHt4sI6KJlRi2waNs82o1EwSROvVR096yonWnH+VQorsD/yZvmG3669swp/yLh1WM7dWjvLRdgITNdt2oUqtX6BRflq1jiDHrRPEVrE5NfBWvf7vWSo9hRscil/5zSqRp544XxuTaIO3/1Bw00/uHj0rF+TJqQfCKBC+7UQ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730723519; c=relaxed/simple;
	bh=MrEnFJyJ0FL0KGR/3BnFLYiFeWGQC8KFn/GmhEG3I10=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZW8zCozDwRT6JqlfVryr9KLmNGdqAym5ysPQSYDVrFUHT8CI3AJ5qN1qxzpn5Id4+yNmhEuocIxExsGfK8FgCGqB5wF1MJi6FrhqZDInPevc0PAD+0ipqekv9iCTz/BGAH0bLr2n38mdm4dbmIsqzwdDjtU51PVIDRBX9d9JrdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEdqPRHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE419C4CECE;
	Mon,  4 Nov 2024 12:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730723518;
	bh=MrEnFJyJ0FL0KGR/3BnFLYiFeWGQC8KFn/GmhEG3I10=;
	h=From:Subject:Date:To:Cc:From;
	b=eEdqPRHf1poKBiq0sfD9MkNLYwKRrejOaME30s39U2mtVFIwul+ObzPzqlchKETM8
	 CS9weGB3/X8faahqaU+eaFhKpeW0lgpH9w+uRdQexEERDRG8XVn481l8zAgGWC6jcd
	 d8rxbFAWHJVvsbI8BTB8Yp5lePoAnJlYvazBVAlPG/C2s8hD95C8+bY+T3Ax8yaKvq
	 NmsaAY7/T4JPwY+4sKjz2pY9t2Dp4Mh+EG+i/Jqeb5tMSyNrtJ8+diucStoXTti81g
	 j7XL7ez1QgWWv/MWCUtG/QudHrNK7H/GubvCDIWRj5GWkcbc6UMDZMlnP29+mCFtz9
	 c0NNHIPBNmhXA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/2] mptcp: pm: fix wrong perm and sock kfree
Date: Mon, 04 Nov 2024 13:31:40 +0100
Message-Id: <20241104-net-mptcp-misc-6-12-v1-0-c13f2ff1656f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKy+KGcC/x3MTQqAIBBA4avErBtQs9+rRIuwsWaRiUYE4t2Tl
 m/xvQSRAlOEqUoQ6OHIlysh6wrMsbqdkLfSoITSUgqNjm48/W08nhwNdigVNtqsfTvafiCCIn0
 gy+9/naEAWHL+AItvwyxqAAAA
X-Change-ID: 20241104-net-mptcp-misc-6-12-34ca759f78ee
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MrEnFJyJ0FL0KGR/3BnFLYiFeWGQC8KFn/GmhEG3I10=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnKL67AubjH+M5KMuClku70sWflW195kd9AIwb5
 7ZTwoTjCV6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZyi+uwAKCRD2t4JPQmmg
 c5mzD/4xNDiBkPjx1RzlrcfghK19ALzroY9IqQNrnq0MrRdip2PkjIe1T2FYj2hvBXCadUXk3qe
 xzqMgdTJzOB0t5eqDH4m4fnLnFmdZz/M1AHQEVh0LTLi18jXj+rcSCrHOIfzwEtQXVl0f9KrrIJ
 HMj7r9+wl1l4PQfGDFoyITwFzkDOEDNIBCZ6oMMDH6b1lrobe3H6fUsjzTynYBBJpjpCfSpoX3R
 +ERIiuCMHQ/6DrgMYh0/PcX2miS95q5FugRvb7PchTZnAo+384pgeun1n1j/owPbS6ULBAaYd6V
 dRrnkVUQgacx+MD8mNtD0GCqC06Ka6EenfI9fV38wjV97AWDH6m0VACaZ3jLgOZ5JhVabDSzAVY
 jURQAq1zb4jNoc0dlZFSYCa2bM1UJ9ZWu6EbFB8b3LeUVSNR/ZMnaklEzlwbZgeJYGkvRBpO9xB
 3l8c/9yd9scg3apnOJ0euYZ7dWUG9/lo95htCtDNgRQKnyHsPf3I4ZJfsL5RSDhI0Cm7fhQQszx
 x7OBYZ0uou/1ZO+KnW3UJpKZzcQMODvuY8Vs6Jeg6nftBOAyhCwjzx9UtvgWr7H8zQmDwTXNb3S
 hQpMVq+AniNj/An8G3DdMiwm6K4P2tOvm0uEEi8yxVgfJppZp0wKmIcIEPxK8FLKIu0FhxgJvJw
 QljJQpKiKMm9DNg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Two small fixes related to the MPTCP path-manager:

- Patch 1: remove an accidental restriction to admin users to list MPTCP
  endpoints. A regression from v6.7.

- Patch 2: correctly use sock_kfree_s() instead of kfree() in the
  userspace PM. A fix for another fix introduced in v6.4 and
  backportable up to v5.19.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (1):
      mptcp: use sock_kfree_s instead of kfree

Matthieu Baerts (NGI0) (1):
      mptcp: no admin perm to list endpoints

 Documentation/netlink/specs/mptcp_pm.yaml | 1 -
 net/mptcp/mptcp_pm_gen.c                  | 1 -
 net/mptcp/pm_userspace.c                  | 3 ++-
 3 files changed, 2 insertions(+), 3 deletions(-)
---
base-commit: 5ccdcdf186aec6b9111845fd37e1757e9b413e2f
change-id: 20241104-net-mptcp-misc-6-12-34ca759f78ee

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


