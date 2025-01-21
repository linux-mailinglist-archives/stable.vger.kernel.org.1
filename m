Return-Path: <stable+bounces-109637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E320EA18225
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 17:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B98188A200
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954171F03D8;
	Tue, 21 Jan 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHYP+43S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F11F428C
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477727; cv=none; b=Benm/HA4hvNRcIjZ4zZH7zi1QU1qSX4W8SSKE+xOFv8lwXDXAaKQcPJ5AYtrFNgXaSGb/7hAREhcNzpZjNCAj3D16AyBucZx24Nq5/JjcKjuLc60T7r8+jUszdeczpqvRLvN7cLzk8WBZYQmWqhFAZkWKb8bmYbdRkIVmM7jEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477727; c=relaxed/simple;
	bh=ERTNqVInCg0XJqqBHzREeOMGHm1XPAOhgvdngMI2GiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=csB3eUmdNdovGM1gl/bVtlDzUsSSZIqUIRSPmTXH3x1uWlmOjG/y5yfpoufvCYOSdQOl/P9G2aV1ykxc76mqTgpwnUNYpnk5Wcqtv7b/+snLCQEp2X0nuxg6dPj/CR3RWu1LWaqScPrNcdzK5kr4xMURPDvCk+Jgfh+RonV+ofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHYP+43S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECD4C4CEDF;
	Tue, 21 Jan 2025 16:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737477726;
	bh=ERTNqVInCg0XJqqBHzREeOMGHm1XPAOhgvdngMI2GiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHYP+43Sm3zkiIHXTbLn/YcUSNhevHEW8BOQxnMDPtKO1WMixT05sDfg6LcIzL47X
	 jEIM2bqQdj8Q7zFZY1+OubVC50A2B/zrBoFrdL2N8IOl5C5hxaD+/hBnLnG6H0FTjm
	 34g4z0NVwmcvrfz7sPkG9Dvub7v2+PM4VZeefMz199JlBWw4pq6ZPex0ky5kt1AKKD
	 jBreM7TtSFQ7G2bySPKoNk3w20Ec2YvU1qK6BP3oWnWX9fBNkJSbwHxwc95Y/ywTT2
	 Yq+ObShSRqiyS2jvjHRMaoawZXCLIEG4pERj18ppLqV2UmJGVlAHiXZmvyaeqYPXN8
	 mradJyfWI3JYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] vsock/virtio: discard packets if the transport changes
Date: Tue, 21 Jan 2025 11:42:04 -0500
Message-Id: <20250120102325-1625ef492b77d8e6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250120150704.103935-1-sgarzare@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 2cb7c756f605ec02ffe562fb26828e4bcc5fdfc1


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2cb7c756f605e ! 1:  95bc6e4a9a892 vsock/virtio: discard packets if the transport changes
    @@ Commit message
         Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
         Reviewed-by: Hyunwoo Kim <v4bel@theori.io>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit 2cb7c756f605ec02ffe562fb26828e4bcc5fdfc1)
    +    [SG: fixed context conflict since this tree is missing commit 71dc9ec9ac7d
    +     ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")]
    +    Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
     
      ## net/vmw_vsock/virtio_transport_common.c ##
     @@ net/vmw_vsock/virtio_transport_common.c: void virtio_transport_recv_pkt(struct virtio_transport *t,
    @@ net/vmw_vsock/virtio_transport_common.c: void virtio_transport_recv_pkt(struct v
     +	 */
     +	if (sock_flag(sk, SOCK_DONE) ||
     +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
    - 		(void)virtio_transport_reset_no_sock(t, skb);
    + 		(void)virtio_transport_reset_no_sock(t, pkt);
      		release_sock(sk);
      		sock_put(sk);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

