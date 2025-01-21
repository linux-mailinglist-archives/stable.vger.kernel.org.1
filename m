Return-Path: <stable+bounces-109638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BCBA18226
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 17:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171267A30E8
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36C41F4715;
	Tue, 21 Jan 2025 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+EgY0uw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FAD1F4297
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477729; cv=none; b=K2rpXgiKlMxkAUQF8vMoo3bDovgFoWX8aY4P07GakvT6O26cTzGsToLkJodXr7Nbpwrs9D1pzyN/eqMozYlNs9pghKELJ3pTq8FEqbfa9vIfKg+mpa1B1xFHfkD7B5MfQC9puEWWegk6mn5AYJPhkg7KJ1KL5W83M3axxruneOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477729; c=relaxed/simple;
	bh=c6bgl1qhrl2+HytPaMLcpdJ495Uz1JQFluvnoRy30qA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7byzhOx/4mXF5/CgR8mMNI8Lh/A3oif78VwoVz+cUoLpmpvrM6TpcyU3i1E0/wtvfkRe8drhLjAcqB2c7UHf5VrYoST8Eyap5pNxg5amMCmpGviU+4YfkjYZjT7S1Lo07Iapzbcls6/dE8uc2RJ0YFcpkEFrcsIX2Kskk3WLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+EgY0uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B63CC4CEDF;
	Tue, 21 Jan 2025 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737477728;
	bh=c6bgl1qhrl2+HytPaMLcpdJ495Uz1JQFluvnoRy30qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+EgY0uwF+1QcDbkp3Mjozy9tp9c9navDLxRfsTIMfI3/7lsBWYWhKebgW0F27NE+
	 KgS2w7Sxql+vkDZTRt1e/3sqGvVVKaukNxLJ7/4mZ+ca3+Jy3vSufVMUSvHo83UQAp
	 joDu+cmImwdYox9HjLd1HwGCaJ+VIn/SW6rmWVQlf1jQ0C0qJ5XmNTIU524twx/onn
	 arPL/AaVRwg+Gz5TBegXTmQJpB9cabYzjPtNJM1WgIe1XI6R/EwC5DXOWatLRxfN79
	 orJBHdVBm7Ykq4PjZm2pjaYfqy8EJ1Bcvrxlmh/7z7FuNsRogcpTZwfth5BM5/VWdV
	 pfoCm6YspXf8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] vsock/virtio: discard packets if the transport changes
Date: Tue, 21 Jan 2025 11:42:07 -0500
Message-Id: <20250120101635-2c3e5b4fe22dde1f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250120150411.101681-1-sgarzare@redhat.com>
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
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2cb7c756f605e ! 1:  f64fe81908cab vsock/virtio: discard packets if the transport changes
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
| stable/linux-5.10.y       |  Success    |  Success   |

