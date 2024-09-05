Return-Path: <stable+bounces-73610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B425296DC30
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7185A288FC5
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C41E175BF;
	Thu,  5 Sep 2024 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8i0Qj7f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1A4DA1F;
	Thu,  5 Sep 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547461; cv=none; b=BEX8T94cMP1Dd5Q4jxckO2FviRbSv88Ze14o+PKziiHo6fDsWqpL4MKp8EYwb3qNXiGBSv85O6B0pHI1LbWLi0UqcgeDk9yBk9fM3qmju1Nczr3Niq29SaE/dQdQQ53dKN14x22fd0Kwx7/m46fDn4rrFZDTfIt/guu7nVoq8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547461; c=relaxed/simple;
	bh=+sIPEZMtPOfdcAWBRS1JF5uCvn0JmI6nsavk0vNBCzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9LQ9WMvy6eehfKyuiGs5DASaPYtqkzVe57Bt2w1zpDF4PR42F9nw4MStJGzacLyEtf7vmXycGl9exBBefpnspIO3y28AVN4nMVaUtRP2Nhlx0FcnDVTFsqM6XxHV/FM2ZDhucMFmKUHkvbFxi5MARIsCYgq9OWasq8NWRDr/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8i0Qj7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8BFC4CEC5;
	Thu,  5 Sep 2024 14:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725547460;
	bh=+sIPEZMtPOfdcAWBRS1JF5uCvn0JmI6nsavk0vNBCzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8i0Qj7foJPPZf/o6QopLpj9UFARP9QYAiOvOKc/tkzFH4tESYdR8EiKSfTuIQkRV
	 J/Mkc+TpllnzdLgchT9l5Gftefy0A0f8iOQbCfnM909K40iUD9EInbK1dYGzr+tvdg
	 0jlGbPDAOHW4SVSXl5o1dB0/mYgDKSasli3jcPMU//dZqoWDT5Na4F49nVUUdQ/w67
	 IuWvqIBPIoFF0o9U819DAC5kN06kd6WR3La0PeT+SvLchqmNMWQqHzP/vkxMOV8F7h
	 NE8N9iWuAvHzsByqztTT+Yux3EjGYlF08F6sgzIVyUib+5U/AFA7PzA96olUQ/UMyh
	 FjIO11hXIXb8w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.1.y 0/3] selftests: mptcp: fix backport issues
Date: Thu,  5 Sep 2024 16:43:07 +0200
Message-ID: <20240905144306.1192409-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <220913e1-603f-4399-a595-bb602942161a@kernel.org>
References: <220913e1-603f-4399-a595-bb602942161a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=matttbe@kernel.org; h=from:subject; bh=+sIPEZMtPOfdcAWBRS1JF5uCvn0JmI6nsavk0vNBCzc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2cN6rmtVq7N+xCsSx+5AvgVolwUZbvYGPGYLm TJiM6oJixOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtnDegAKCRD2t4JPQmmg c7t5EACzTNdSg4Q33IvsTSWbWRUndbnktzpNAEzOVdAWj0xs0O2ClTCqCL+o5x7uuf1b+enss96 fWzXp6UQ3BEQop+5xgHkfV0JAy0oX3FOR0mbYSD8Xeyz4xHB4v9dGqeLbSxmgFVYeSFhah2Oc33 fsVCH7F9fW1Nc4GJYg+muJMkmuWejxCd3LeVHe1ykGm3KBvF/ArEXlPeVCci+gr9h6fqgjIvUbt wPpmJ3gIbJ7g734WvTk4kiEab88ySNPToYUZOjs8ktwbXim9zcH5E1W7L55grnZTZrw3I+ogcXY 51IQ30MM1kJNXL8UM329tyRdQT2yTRhm+rcA5LEhGn32ms3NM5WNp+mMQyT+AqC24P4Jpg36qG2 SekajaBhyxn1aKzApJQqzUJfAZVWhC9niHpcRRoPN6eREOHDuzXgUH97lvAWHtJo6h22YOD97Yk 9QejHODer77Lo+tb8gdVjVx+uXOL4EOojtPwFa3ybKQxkwqsC1YWIsUPFh2s5UocQ7vtdyjOFPX bmwbFEUhJKQK+J2RHBAK1aPZGjpJoLqwazqgqnYlqoEgMODZHjm4Di+ozR3mRiXi9wbc74META6 xI/NIC0+tk+MsNw6euwHRz/Wxb1UAjLErqlPH12U2QVcIUPMIMz+yMPMc/zvC19lG9RmMQBVHto CDocCh8gJ2cqPqA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported that two of the backport patches I sent for v6.1
could not be applied [1][2]. It looks like it was because some other
patches have been applied twice, using different versions [3].

After having dropped the duplicated patches, the backport patches that 
couldn't be applied were still causing issues. It looks like it is due 
to quilt/patch having applied some code at the wrong place. This is 
fixed in patch 1/3. After that, the same two patches can be applied 
without any issue. They have been added in this series to help just in 
case.

Link: https://lore.kernel.org/2024090455-precook-unplanned-52b3@gregkh [1]
Link: https://lore.kernel.org/2024090420-passivism-garage-f753@gregkh [2]
Link: https://lore.kernel.org/fc21db4a-508d-41db-aa45-e3bc06d18ce7@kernel.org [3]

Matthieu Baerts (NGI0) (3):
  selftests: mptcp: fix backport issues
  selftests: mptcp: join: validate event numbers
  selftests: mptcp: join: check re-re-adding ID 0 signal

 .../testing/selftests/net/mptcp/mptcp_join.sh | 234 ++++++++++++------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  15 ++
 2 files changed, 180 insertions(+), 69 deletions(-)

-- 
2.45.2


