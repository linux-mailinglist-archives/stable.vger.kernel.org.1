Return-Path: <stable+bounces-89201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AA89B4AF7
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 14:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887F2283BD1
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED58205AD2;
	Tue, 29 Oct 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ftJCncz0"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF037BA50;
	Tue, 29 Oct 2024 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208735; cv=none; b=dJ061YbtovlIUVVW77NS2g32LAh3+MsA1mkKYWrtWqKglW8erAzqGMLPgxCxzTTfIdZx1ExW2Q3yp7ppHE2ddyL387uDncnPwuTJW0x9PUlluIFO7MLup2iQ+r/SGp/Oil/quPAKqc5X3G3wC3eiOI1XjQmQPMNSI5npibYFnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208735; c=relaxed/simple;
	bh=h+3XDlW6T/2uheGXHlR7H84/H84D9Vs/nAUE/JVwEwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nSeP2qxnhnv7SgIGJPg5K0SsIGpMJd7RkrgYniuF+szAnnQ3zIM64gZYm9iIwW+8CzDkf9OFYWnsQIHkZ0iffmeHHCuAcPONAxPtTKYecbyIu1EnReA0SP9rgploHByFB1dg7yu5CZYOUHYHVWEykVSdrlolPXCbGL1xQUb2gfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ftJCncz0; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id EAB4E40A1DA8;
	Tue, 29 Oct 2024 13:32:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EAB4E40A1DA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1730208723;
	bh=h+3XDlW6T/2uheGXHlR7H84/H84D9Vs/nAUE/JVwEwM=;
	h=From:To:Cc:Subject:Date:From;
	b=ftJCncz0e5MIm4Z/yaQ3uNRRWlnNDce39E8zxZk0yPtHeputXrErzMOHxlUkCnvxx
	 3VtKRHJ0oVoKL8BOMF18L3lHAQvDuIqm1qptvweIwTWGBbxzGNNEGzf6aM+nlwPaa+
	 nWPL4vgHbwQReqP0Ksp9TjtBCAkm5lDkFP83FbX4=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jonathan Gray <jsg@jsg.id.au>
Subject: [PATCH 0/1] On DRM -> stable process
Date: Tue, 29 Oct 2024 16:31:40 +0300
Message-Id: <20241029133141.45335-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I'm writing as a bystander working with 6.1.y stable branch and possibly
lacking some context with the established DRM -> stable patch flow, Cc'ing
a large number of people.

The commit being reverted from 6.1.y is the one that duplicates the
changes already backported to that branch with another commit. It is
essentially a "similar" commit but cherry-picked at some point during the
DRM development process.

The duplicate has no runtime effect but should not actually remain in the
stable trees. It was already reverted [1] from 6.6/6.10/6.11 but still made
its way later to 6.1.

[1]: https://lore.kernel.org/stable/20241007035711.46624-1-jsg@jsg.id.au/T/#u

At [1] Greg KH also stated that the observed problems are quite common
while backporting DRM patches to stable trees. The current duplicate patch
has in every sense a cosmetic impact but in other circumstances and for
other patches this may have gone wrong.

So, is there any way to adjust this process?

BTW, a question to the stable-team: what Git magic (3-way-merge?) let the
duplicate patch be applied successfully? The patch context in stable trees
was different to that moment so should the duplicate have been expected to
fail to be applied?

--
Fedor

