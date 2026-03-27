Return-Path: <stable+bounces-230707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Px+CFrJxmn5OgUAu9opvQ
	(envelope-from <stable+bounces-230707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:15:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9669348EA8
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 648ED300A10D
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32273401A2A;
	Fri, 27 Mar 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWcHRhx+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E740148F
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774635233; cv=pass; b=scKRUEyimZ3qPlblzgOoOzms7+kRQibnbrlIImIbV3TpIX5WHEyzeecryzoEEnkO8aZt4xLSfNGqxeIJJ+BBU4ew6+bqeeVhkrNXZZh5XPhDI/UFZJZWTqfAuzIQepTrbxjXr9qMru+8AQNmLQ/TVnq0a3o5Q2kENBKKLU9nNdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774635233; c=relaxed/simple;
	bh=PomC0oS5CuuImOTnjYhtKxZ663q+D4Qa+tGklzvibcg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KiIlwgJQi7QX96HLAZR+ttPnZoz4FXub5G3hZcb+VnWy/KG5biYl534wdh3KtXHkAws0eznxLg7h89+KShzeS6tG6pGHmVf9kc6j/gC6u7JH0jBbCwPgaovh6gtp4gNRyI60312tdBLZBAlvnfAKrb8IW7FSe0zcaZF9mKukC2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWcHRhx+; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64c9a6d7f81so2454929d50.3
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 11:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774635229; cv=none;
        d=google.com; s=arc-20240605;
        b=VPfFWevBJKy++YsDyLmXyGiH/SO05xDR/VGa0uLRnSvAJyKYhztdtIyYMNBYgvwmDx
         T7GcUo/okPVgN2loXAQuaoOLd3iQvwdbUcMAtofSugQvtl7urmKZdpsyYFK+nBjjSznL
         5CdGe7iT2pvnNqESmQGqltpV8OdAWe29mO/aGyPCuu/L7ZwptKTpVTWKVAerc0dBicmf
         gl9A0tYRKX29M4zq9vqPMOEByWPBFEGfWCSudpRO0+DOgQ3fepzEhb1us/6k8dZK3HnN
         TEkOuGEKF2ccKWT+QcOcBjlZ6HCIBjT/9BHm5pDpiBre7Aj49Yw3TT+GMdbg5yX+U0tH
         8gsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=p+wY7nudsBUevwgkVemBDLjljU1N+r4KZ6n0hiiepL4=;
        fh=W2PKFq3Z9Ps0Jw+GreuNM3cIf2LRCGgo0ZilY+a+cp8=;
        b=PJe4TYLiqLr8gKI/y8Ck6EtiohcpMi6VIc8W3rOw1so7X5acemmBAoxDYpMBX9KZDH
         rVBuwVj7GnWK/CybmCfyQnyOnp/gzy2xRRZCOw4oCQreJVayTKYRhnUCZAsCtnIQZBHP
         10Y1Uu1oRPrihimimYjyYCvzT65CWBDW6sd76nqOb2xUTTDjsZCbb8y7794qya4QY/Ib
         UgQCMLtyoNFEuVV75ba8S1cyi9AQfADKDyAC1KJjycLiZ6sUPKbvlf8uOA/UZeGCphT4
         91HqUGDkJjQiYm9tAzSL0F5TA32XsVp1vSeIlvOoApYChtQ4labxNaQwudsS7oCOfydK
         jvAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774635229; x=1775240029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p+wY7nudsBUevwgkVemBDLjljU1N+r4KZ6n0hiiepL4=;
        b=jWcHRhx++JZ9uv/5BN+9tCrS7UAGIosgCVjZ9j5GCMWEJgZ+6ppU02xr6hRHupsuxK
         7SeNly1d5ezR7a1DBMRX3gcLQcNDq46oDLuRoDBPJvf8GJ4qKWr2MBYo2z37jWqcSSmI
         rscZM8dd3jFrfsxL0QlC8DGIO0hHUUmwMma5BlKKA6MSYzuZGH5g5wpsXJVK5Sd9SWce
         uo4g/e4f5eKbBtatIEW7wEL+4ah+16F6z98srYThKGr5lAVaO9DQmd7CmnNTpHug+w8Z
         Id8t1e3ZfD6E3MhJBRChN9vp2cEK5euWbTpUTlhh6xUTVbhDkhBM79iY5KdI4Ob9pWrZ
         flpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774635229; x=1775240029;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+wY7nudsBUevwgkVemBDLjljU1N+r4KZ6n0hiiepL4=;
        b=JSTCPEJMQ5pQLAmn/XIqCu0Me0yotXVU7NwDEYF8SFRTfo/aI9Q1XlRzKevwHJy9ud
         zFK3vj3ci8sthqzR5C+go3rnp0e2l0Rtw9wWYdFWwG+r5jFWv2LR67u0koajz/tbSSMY
         4V6ZlWQI31dAqHdPmlUAwxnX68wdA1LQkt0j4uI1MezYmCcJrDLsduDcGblWF6+WbwQj
         TX1XNWbfkmUMDbC1LgFov7iVtgH1J9MTicXWxViEVaPzk/sTd3gURHgt4HMA/0UuSxjU
         q1UKifLk/aBW1j1AIeQPAA3HflbE7MB05sf7UM9gZ5CXLSpMQGOA9C5+Y31CPF9WJI4y
         I+0g==
X-Forwarded-Encrypted: i=1; AJvYcCUfZZSHMdPnCuI4Xp53j1GMk9no7kWlEDFqYnM/a/OrlJ3dXN6CWMFEaB37Bqr+HFflxrQgABU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLiQoJtrdDg4BHvvBa61j69GMFyyJLz2NlZw9H8HzDMY4vOnxD
	R14pdFwwKD5qlMYDAB76NhVtUOBUXKj8VJ3RVz1toQCCyOm/6ImtWSOna8VEzh4DYs1LxptBH/S
	+47gCt31iJ7bwlXMtVoVOV59ZGnQHE8t8OxFt
X-Gm-Gg: ATEYQzwByzXtweYVg5LkAgXnNy/Dj1gnirlxzc3mPKijvprqps0an/hbwY/PJewH6Sd
	+dT1l0ajksoAP8y1ZqCtFjFzpow92zaGKd//dqDGDb7/Dpq8O8QB+Wk33e4a75ZhwJ3Pq8K/zwl
	8z0Rj2Uz9xdkrebD4lksLr//lWjoo10XIWCdiVrwPfkFb786dgJEG0kHABT5Rb7xOGxlIxyRhiR
	hbNPdba2A9nj8ycTsoJ+speutKK0gxSq4xtoAWxByj6ia7XqrcjIuYTljn/vDzVabNkJhOH/BBR
	1HRgfkKqezpx1fXwqtrZkG9qFc+oXYlQtJ3h78BSIap+whXOxbQLk1xJwvTLZS9jejA/PW7O+gi
	iYu+N2M2uuFQVlTflG4LPXEN0k6I6zs6WN0uykoJIsK5lrrghBg==
X-Received: by 2002:a05:690e:28f:b0:64c:9a9a:e2c9 with SMTP id
 956f58d0204a3-64ff741ad66mr2718343d50.60.1774635228140; Fri, 27 Mar 2026
 11:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Fri, 27 Mar 2026 11:13:37 -0700
X-Gm-Features: AQROBzCmlSmEqZs4hMI2Z9xBrY5G4JyB7qj28Y6BMnYe_KKxzMDly9Vsr4RRMYk
Message-ID: <CAE5sdEiLuFj_8m89PGJwFit0QHg1=TL6=O==Mirt39BfbrRkVA@mail.gmail.com>
Subject: [Regression] net: tls: Change async resync helpers argument
To: sashal@kernel.org
Cc: apais@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230707-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sidchintamaneni@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9669348EA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 74bf749662a29 [upstream e98cda764aa9c] is backported to match
the function signature of tls_offload_rx_resync_async_request_cancel
function that is introduced in Patch 2 of this series -
https://lore.kernel.org/all/1760943954-909301-1-git-send-email-tariqt@nvidia.com/
but this break nvidia's mlx-ofa driver build which is still
referencing the old driver signature.

Build environment:
  - mlnx-ofa_kernel-25.{07,10}
  - kernel: 6.12.68.1-1.azl3

Failure

466 |         tls_offload_rx_resync_async_request_end(priv_rx->sk,
cpu_to_be32(hw_seq));"
      |                                                 ~~~~~~~^~~~"
      |                                                        |"
      |                                                        struct sock *"
In file included from
/usr/src/azl/BUILD/mlnx-ofa_kernel-25.10/obj/default/include/net/tls.h:6,"
                 from
/usr/src/azl/BUILD/mlnx-ofa_kernel-25.10/obj/default/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h:9,"
                 from
/usr/src/azl/BUILD/mlnx-ofa_kernel-25.10/obj/default/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h:40,"
                 from
/usr/src/azl/BUILD/mlnx-ofa_kernel-25.10/obj/default/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c:6:"
./include/net/tls.h:461:74: note: expected 'struct
tls_offload_resync_async *' but argument is of type 'struct sock *'"
  461 | tls_offload_rx_resync_async_request_end(struct
tls_offload_resync_async *resync_async,"
      |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~"
/usr/src/azl/BUILD/mlnx-ofa_kernel-25.10/obj/default/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c:
In function 'resync_update_sn':"
/usr/src/azl/BUILD/mlnx-ofa_kernel-25.10/obj/default/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c:562:51:
error: passing argument 1 of
'tls_offload_rx_resync_async_request_start' from incompatible pointer
type [-Werror=incompatible-pointer-types]"
  562 |         tls_offload_rx_resync_async_request_start(sk, seq, datalen);"
      |                                                   ^~"
      |                                                   |"
      |                                                   struct sock *"
./include/net/tls.h:451:76: note: expected 'struct
tls_offload_resync_async *' but argument is of type 'struct sock *'"
  451 | tls_offload_rx_resync_async_request_start(struct
tls_offload_resync_async *resync_async,"

Reverting 74bf749662a2 makes the build pass again in our environment.
Let me know if you need more details.

Siddharth

