Return-Path: <stable+bounces-134891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C610A95A43
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202273B4BE8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 00:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8388413AA2D;
	Tue, 22 Apr 2025 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsCWzjbG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8DC139D;
	Tue, 22 Apr 2025 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745283072; cv=none; b=oa2sH1pH1NkuI/6cPOe2YKhwmpxTNL38tilyskOds8ntwPwsDq7i8yzrsSPlVOsOKHqxBUjWNOSB3Bb4rOa0XgZ5QMNlWNptghUgeTgVES3KdVS1r8+QsE0gE7PXLMTVwIe84TOqd+iBXPMWM+eGu0SolK+TYnzsWJfZ1Bk8ogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745283072; c=relaxed/simple;
	bh=zLhy3BRXKnSFeoj8jm4eW64R3HrNid5Ecrf0Iy4zMaw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ke64BXkuH9Pe5OskJFaXPz2RptW7aJua794suZohlGl95golv9EV5BXtyzIOxLIHJpmw53CAvZ/fClqNqxdgg7aejOMdGK5Cx1QY2QIKwi9yN+UVEUCgZYnIkXsZYfSAKka6S76US2Bmqd64KUFMh7PNCsnaFJPvLZgHR9AV8Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsCWzjbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A19AC4CEE4;
	Tue, 22 Apr 2025 00:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745283070;
	bh=zLhy3BRXKnSFeoj8jm4eW64R3HrNid5Ecrf0Iy4zMaw=;
	h=Date:From:To:Cc:Subject:From;
	b=hsCWzjbGO0tN3jQrZFjqRXo9bkSpFdHmoWTV/hgOeeBanyJZzHGQimm7ESNKhWEGZ
	 bZj+7Uuyn3jMqp4X8AwPmgl3+SYUGy8zyh/rrI4BL8t0wva03Tbpy0WuCvGXaAy8Iv
	 mT/+v7ck0Hqtw+z8dGzAnWtyS3IPkWTSDA3ibfkB4BYaDdiI9AVDeRwDLO80n8Wcp6
	 Th0pfH8FgpmqrbRIp6EDhmQ2TettEzHJOCX0txPS/uWGv8hIW9aeMFvvL/4zO98kTG
	 pprWO7Uyo5/DxZelvjO17SrCsoeO6PUCCw2TWrE5i+S5JLCb0Ybp5iQeix6wEmfzBU
	 nEtOG+41T+VSQ==
Date: Mon, 21 Apr 2025 17:51:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Please apply 8dcd71b45df3 to 5.4
Message-ID: <20250422005106.GA3437285@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Please consider applying commit 8dcd71b45df3 ("powerpc/prom_init: Use
-ffreestanding to avoid a reference to bcmp") to 5.4, as it resolves an
error seen in that branch with a newer version of clang that looks for
loops to turn into strlen(), which it is not allowed to do in this early
code. It landed in 5.5 so it is in every other stable branch already.
Please let me know if there are any issues.

Cheers,
Nathan

