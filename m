Return-Path: <stable+bounces-158409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D316EAE67B9
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD821BC530E
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 14:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095992D8765;
	Tue, 24 Jun 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiIZIxUE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2092D321D
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773541; cv=none; b=KCgY5wm5C39C45Vc3SF1ckXG0e8rnSFJof+SUVOqA/b997k9iydmjDPlPSrt66PCxm7vIcn1GNnlplJTVksthSCnztUZH994JibewlPCyuCNXuoAM8qRWYTdYhWdzskgjEGrZp1CeVjkjntCMj0rPlzKOo6mrHaXPTi0X+7omxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773541; c=relaxed/simple;
	bh=+5ULGEw6UPrccFtqs7h9l7/yCKmsA3x/0cOGXuUWX5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjF6Azv+WSg5kkGOkvWhVwoRVNBY24ioh0uNiBmUZLNHlHYxLOotjsNltaoHxJGl/Yius8lKBlX8HQmXvUw691xGIvcTHCFH2uXLjV8Mt4mlFKRk8ZuXOczyocQayoTJzufopkMQlv4NUrG1Sm8ki5ApN5M4GrWNeKIGBEKeIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiIZIxUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D496CC4CEEE;
	Tue, 24 Jun 2025 13:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750773541;
	bh=+5ULGEw6UPrccFtqs7h9l7/yCKmsA3x/0cOGXuUWX5o=;
	h=From:To:Cc:Subject:Date:From;
	b=FiIZIxUEDki3WHtOz5MOaeQKdse0wpZ+nltLI4LKHyFtfsPgp6ga6ZOffYMt0oihZ
	 AZEQKFdNej7AlrPX2MVp4ifOnwWDcPXBfF8WM26dEGfKpbOxNFyFa6r3rqHSKqulqK
	 8BzDqssPkybommDKp5vs7A+JRAB60/QxZQHQ8dvm/8YkLAWBHNwFt4b/69knAl8b/3
	 /ubFJfMXeArdWUaAUFjH3Ljc1VatW1UL+DgNWBjuNVkPfjQ1G4g0L/nMJwWwz5WywV
	 Mu+KT6pwXAolUusRQkCoBNYxSequ0cTaEaX2QrOxWQoSKFf/ttvyBOOlooDOXMYy0P
	 poi4OwBM3hSlw==
From: Danilo Krummrich <dakr@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	lossin@kernel.org,
	sashal@kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/4] Devres fixes for v6.15.4
Date: Tue, 24 Jun 2025 15:58:31 +0200
Message-ID: <20250624135856.60250-1-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in [1], here's the patch series for the Rust Devres fixes for
v6.15.4.

[1] https://lore.kernel.org/stable/2025062455-rogue-flagship-54a4@gregkh/

Danilo Krummrich (4):
  rust: completion: implement initial abstraction
  rust: revocable: indicate whether `data` has been revoked already
  rust: devres: fix race in Devres::drop()
  rust: devres: do not dereference to the internal Revocable

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/completion.c       |   8 +++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/devres.rs           |  53 ++++++++++-----
 rust/kernel/revocable.rs        |  18 +++--
 rust/kernel/sync.rs             |   2 +
 rust/kernel/sync/completion.rs  | 112 ++++++++++++++++++++++++++++++++
 7 files changed, 175 insertions(+), 20 deletions(-)
 create mode 100644 rust/helpers/completion.c
 create mode 100644 rust/kernel/sync/completion.rs


base-commit: a2b47f77e740a21dbdcb12e2f2ca3c840299545a
-- 
2.49.0


