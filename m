Return-Path: <stable+bounces-73004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4EF96B995
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC231B23EBD
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F9B1D0140;
	Wed,  4 Sep 2024 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJclhyVL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420731CFECB;
	Wed,  4 Sep 2024 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447797; cv=none; b=CG5oOYuhnlGH4LJtPoCtE6hP0/P4Bp320pf0YrbzIAiQb/ju3TLOh7fUEgIDZuq9zxU2tZ9ui1i3NoKQdFCEuVt4vjkxP610QULui4s+16qGmyg3Ouw2rsV47brPbWSmb4dVS/30B1ng4f2Z2NT+FZVfiBKeT6vtxBxbd1+rvYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447797; c=relaxed/simple;
	bh=Nb5xjIIce9wUtDPSeZCSRm/Ua+5kp+iBduiF2bdExoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8E2sIa9s2k+tyCv/iLKYs268Wv3qTd7G/PRpJoqBMD7MJRrq3TkX0WXBL6aTiTScghNPNMHbssTxYyaI3ShMKIxKuhIlX0VQNp2RjO10l45d19s5ggkX6f3vAOe/2K7I1o3B8VGxCHtqGY65M2IFUWDYoXJA01snWiqJsj1cZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJclhyVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D20C4CEC2;
	Wed,  4 Sep 2024 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447796;
	bh=Nb5xjIIce9wUtDPSeZCSRm/Ua+5kp+iBduiF2bdExoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJclhyVLjkYt3kzR0Osil2lToA6LSDYT82G1i5vZSOmJa8jkukf4n0aMLldEeYB4y
	 MkG+5bk3bl8zQpCj3tM56pxpkmfxt0C65JyG3s95uEu6BC1H/DH2h+Z+ehI8zvyV4A
	 h2ZGwloNppqhRb0oe1QOI93TgG/BTu4ZdjhC31fpPu2lmQyEPn28wGHrcV72H9IRUT
	 uh9UA0ZUx4tX9hNQH9lKFjIy3gazWEPqtXnW3QwM0EDVnhAlYs1Ed3iPhnSOQ1qBXj
	 PXdkkbesp/v2WfcLEBHv1XtexfkF5O8DO6lydMBhXbnKk1Acuvgj5Oou7JIVDPjCGJ
	 QV2n3ndgo0Gdw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.1.y 0/2] Backport of "mptcp: pm: reuse ID 0 after delete and re-add" and more
Date: Wed,  4 Sep 2024 13:03:07 +0200
Message-ID: <20240904110306.4082410-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904105721.4075460-2-matttbe@kernel.org>
References: <20240904105721.4075460-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=691; i=matttbe@kernel.org; h=from:subject; bh=Nb5xjIIce9wUtDPSeZCSRm/Ua+5kp+iBduiF2bdExoo=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2D5qE9sk84dHvOmouhSL6Bc2gA0c6B8Y5OrDG 8VKjma78SKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtg+agAKCRD2t4JPQmmg c9gZD/9YmVrOGzkU+jCGrRehy6gyG3LZOEXp+gYoopRGoPZ/9BbMX61alQ4cmtqJcfPOHmCtdeW 10m4QbKO32zF+7mnq6pH7ZclqSFktvEJjmRo1XF24M8pZ66InvQsmisBYSa6IvPegYpmEvPj6a3 8ww2sh6XS3pny9Cxg+kxa2vD4emoXJ6+Xg+U5Cyh3JU7o0l2csq0kUdMVB8KS80QGEf2GBb+uMb om70sOPqOFqK/MqWHwoZ3vMOdndUz+H8sLvW3sf6ydzWXSKfNs1vK0RYshYOYtyeJfOp/3JCSvb IIpN0XSQJLnsK8GvzVsIaczeY76Rjy8jKWD3Mr8Eb6kOX794y7UH8EeZOhHBoCdNgpBu+bolQTw qY7+1C2EEqVeE3bpmV2+SAS7fmvK2ioA/laQvXsNhHWrd9x61hALg4OnX5FgT8jtTVxO+0n3Vgu NfPH+0Ab0YVLGG9T3JAQyN+5PsLXsvrw5qg7k97cmQ0rKlOEvTtccATjD8t9X8dHQUlMntEa+lX uN+b+zVf/EtfOgxT124CVbtLmt/f+jPKHqqQ6xhuImpU1Lci0cj/H2+l+9b3hFEx3sizR6ZVwOP i5/QsvCJyjH1Vwn9696kfZ1l46w83BQaVVSI88SeaqrMjL7Y3MTXPUrxDSkj0v6Onj1u1MJtolI +VPZJ93Bf5yq5cA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

After having applied the patch "mptcp: pm: avoid possible UaF when
selecting endp" in v6.1 with the adaptations proposed in the parent
message [1], the two following patches can be applied without conflicts:

- 8b8ed1b429f8 ("mptcp: pm: reuse ID 0 after delete and re-add")
- 9366922adc6a ("mptcp: pm: fix ID 0 endp usage after multiple re-creations")

[1] https://lore.kernel.org/20240904105721.4075460-2-matttbe@kernel.org

Matthieu Baerts (NGI0) (2):
  mptcp: pm: reuse ID 0 after delete and re-add
  mptcp: pm: fix ID 0 endp usage after multiple re-creations

 net/mptcp/pm_netlink.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.45.2


