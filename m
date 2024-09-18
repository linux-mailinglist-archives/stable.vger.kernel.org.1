Return-Path: <stable+bounces-76680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA90F97BD9B
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 16:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722DD28D40B
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F8718A944;
	Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo+ZYdL7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30249176230
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668247; cv=none; b=mTsuF2astf2HrV3+HYl5jZu7EsoJFhNggthe2OBvdqqY8wWgy8juh3cMLj4xMwfvNu2kpX8yATQnoGe++P1ztjTeARkoPL3obcFMgCchDOV0IPGx2LZnTItIZd6lcyuUo+VxXd15oDs8StAFdAxLnHkpO8yrnjjyDL+lGbRyqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668247; c=relaxed/simple;
	bh=nbdCCOPAmbbOfYquegg2cWGUvC5cAPuWKrmvcNQ2fJ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ws/kcpTDNUH4OfHJWNdIQ1/1+Gbg8a0mXf3JkPz5vTxZ5yCdpO9GDUu9M5qEbZEBEGjkobFoMPwLfHM+y/2fZP8RMrcpZDhEGRMNTcRZdfUhnOUYGmTJr3m3eCWMCTwUFYqC1oNqzM8Eyd1VVrpNX/LkazpOKWZoA34zVQn/RKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo+ZYdL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0392FC4CEC2;
	Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668247;
	bh=nbdCCOPAmbbOfYquegg2cWGUvC5cAPuWKrmvcNQ2fJ0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mo+ZYdL7f3DN9FoDwb4EUf0Ebikk4l7bo2PogQFdEWdb7pdIHmMsBkNKgd8qkNH32
	 fLnP8OrdmObsDAMP8eQsyE1TviOaFTUmfxp6ZlJN3I4YSJ2HvQQig0qIUhghsDx4oG
	 VeTCBLKWF+GWjgvyIE6dDLwRtP8/Txpc6qWV9oNWfNOil/DPN6oFkoMDO9jAwfr+xy
	 HJ3OvAL1V7ZTpyrpsPmEoeop/xS2Qoh9V/mYjiF1xHdef7igEe7QyuLMPDK6bxPQeD
	 yuu/s/SopEEV8qkNHn/3mpCk6ALfVlwjsxon+x9ycYx/XEK9kCDI9ZD+fkZ7bPSV6D
	 ghJTExfOPEcdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8812CCD1AA;
	Wed, 18 Sep 2024 14:04:06 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Subject: [PATCH 0/5] Backport statx(..., NULL, AT_EMPTY_PATH, ...)
Date: Wed, 18 Sep 2024 22:03:56 +0800
Message-Id: <20240918-statx-stable-linux-6-1-y-v1-0-364a92b1a34f@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMzd6mYC/x2MQQqDMBAAvyJ7dsW1kjZ+pXiIcdUFiZJYiYh/b
 /QyMIeZEwJ74QBNdoLnXYIsLgnlGdjJuJFR+uRQlVVdavpg2MwWb3Yz4yzuF1Eh4YGvNytrlCa
 rO0j56nmQ+Ky/sKuCoL2uP9b9yqpwAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Mateusz Guzik <mjguzik@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=nbdCCOPAmbbOfYquegg2cWGUvC5cAPuWKrmvcNQ2fJ0=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t3Ul9gTDTMIDlzlk0KI6aMMkSbJbDh9jSddv
 i637cz1O7WJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurd1AAKCRCwMePKe/7Z
 bkquD/wIgINwB5xWq7oqdxIGHHyfUVpjn/pBXPntaU7Vu+uk9+zGC7zGK1L7Sj8AUnHnV3dll6t
 MaigtPkZvBE54cCzPFA4gb48xxo+KGRlirZdgKMsdGvj0dAdp2HTDrtd1cE7A0O+lXbaq8mRQdH
 xcF8kNTyEKni3syz1bZI0JpksNNL5yUT6EgZ01qv/Uuvtn/WEE/hrnLegEpd6KIiWLXTCOZ820v
 M6qg2vxFPq6XqadrWQG09ZuIOGmzLWCblki3fr9hvgnwuzmGnri6VYXGF5XlOELt6J54wNmyFjz
 kHww6lhAjo8EF2QvATRdR10we+suORJrbeWAtDzjBrlK4ilq7sq6NL4BU70sav/PT6MNFnTz4DA
 bWmsOhzBhDJYvrf1jtYrRfiEhPyEkaEVPjYgaZpdjvWdLRxjo4ltULpbqn/BAaw+iIJT3VfLP95
 FcoAH/OwZ43oyngThbb4rBlI+kbsmqK29fRhh5eswCOG7+nMdyImv9ylUrTflP6P8mLanQHCCYV
 u7K7M1no7Vq8q2mEHvk18An3Co8/e21MH40uRrnP/62MucP7j0bfySuzWPTsucOGsO0B68KFywd
 Sn+xGa1BRxWvg4Pp6Y23vFB9K1HBgfE0yHl+9CiU8kwTgxxhhQzjN/MoZYABNaXnoc2Dy6ArUut
 kIaK8Fj23GWimJA==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

Commit 0ef625bba6fb ("vfs: support statx(..., NULL, AT_EMPTY_PATH,
...)") added support for passing in NULL when AT_EMPTY_PATH is given,
improving performance when statx is used for fetching stat informantion
from a given fd, which is especially important for 32-bit platforms.
This commit also improved the performance when an empty string is given
by short-circuiting the handling of such paths.

This series is based on the commits in the Linus’ tree. Modifications
are applied to vfs_statx_path(). In the original patch, vfs_statx_path()
was created to warp around the call to vfs_getattr() after
filename_lookup() in vfs_statx(). Since the coresponding code is
different in 6.1, the content of vfs_statx_path() is modified to match
this. The original patch also moved path_mounted() from namespace.c to
internal.h, which is not applicable for 6.1 since it has not been
introduced before 6.5.

Tested-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
Christian Brauner (3):
      file: add fd_raw cleanup class
      fs: new helper vfs_empty_path()
      stat: use vfs_empty_path() helper

Linus Torvalds (1):
      vfs: mostly undo glibc turning 'fstat()' into 'fstatat(AT_EMPTY_PATH)'

Mateusz Guzik (1):
      vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)

 fs/internal.h        |   2 +
 fs/stat.c            | 101 ++++++++++++++++++++++++++++++++++++++++-----------
 include/linux/file.h |   1 +
 include/linux/fs.h   |  17 +++++++++
 4 files changed, 99 insertions(+), 22 deletions(-)
---
base-commit: 5f55cad62cc9d8d29dd3556e0243b14355725ffb
change-id: 20240918-statx-stable-linux-6-1-y-37e6ca691c9b

Best regards,
-- 
Miao Wang <shankerwangmiao@gmail.com>



