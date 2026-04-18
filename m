Return-Path: <stable+bounces-238600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDkPHV+/42m+KQEAu9opvQ
	(envelope-from <stable+bounces-238600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 19:29:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C2F421CEE
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 19:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 069DC30055CC
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856C9331A66;
	Sat, 18 Apr 2026 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEfXjr5D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36363203B6
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776533333; cv=none; b=BAiReZ2So6fNfK4KTv0kmwMw1F131orN0gaXHoiTAMqwu6gz6kYs1tS6squHd4fze7i9fstMdl4GcwjOkITZIAyZ2Qmiz82Va+7JDFclu7SO8HhdTn1SKYISFAebgyI6EyeBTJ2S4XH2fF1VDDBWmMQ67ZoGWGIaids3v97p6QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776533333; c=relaxed/simple;
	bh=oodzrY0vvZIZe8xiTS/m05LLTN+vBoFyUaBlwdynK+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cRPqS6W2bZmvQT1SvLkoPJ8gUPHOq2t/QLwlrBCYhB67/zZB5rkC6ObaqI9n/r81UY8jTFKsB1Qnd0Z8BUyI9Ti78QkUlkgUkh9DgwFQKPopGW46RrJ4ff88WmCeNYh5zKfyPOTfaEfUdrSnTcYk+tvgp4Vv8rS1qgvHUkUpsOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEfXjr5D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad2b375e58so1348135ad.3
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776533330; x=1777138130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKnYTxLMq3it/33zgMBz+MbkLOEWdzF/N2ceulBhKMs=;
        b=VEfXjr5DAq8PV7JdtFABrctkWQfBW7dDQJQv5sKcht44MjxFJoJOfw1CZPtePDYTvn
         msJ8yAkoNBpdnyvAKnJz86PbmhrNzLsLLQzi17x6lWVUWMPWYpSMaleA/1ucO2OKMw87
         2dtvA13sOv2IrCm5OXx0hM2JBU5JXT05fi7r4LQLWmtmozLSLQrXVuCRU3YCvo8FXjuN
         ao1cbQnjCEgTFX46jzvZEYRUS8d2ITLEwPX6sw2E7iJFcfFwDm3Rcwllw6bzcGs+ydAz
         NVZ0SAB62I9kfyjoDSqwHAgBcQvs1nfEmMrB61qecAFu9sUqs8gwMPWVOwpAxofK7vCD
         CssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776533330; x=1777138130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKnYTxLMq3it/33zgMBz+MbkLOEWdzF/N2ceulBhKMs=;
        b=VjXzJoKbfdN80nYOOxwhw8WC5gnuEXOjfJ+hRVtBZ/FKpHGVphm0qc7xFMXIrPY686
         Hiiq0iRVboF0CA44+m1E1OZA0IJJ8vMfbWVaOB+/hMeUcScOeVC23MSCPdsmOZ4DSkmd
         PqECAu5CAGkjrwBbFsPFpo+yxnwELIPGygbw6iMUXm0vKDL2AjRdEedzfEIorcSk7Uqk
         oYXXKa4vdzdIQayzvczndfTJihJOj/q9q0hszWEhW4Hq8CvJ4s2YoPsA3rgmbyCelg5K
         E2EQV40EIKJTQPtPFBJe4nOhvsHZ6OUW4B6p2N4D6cMRYuq92UR+13JrIvey3EkLrilE
         1bvg==
X-Forwarded-Encrypted: i=1; AFNElJ/jgVBMGeu7ofd6xKxIuxhGQU6RO+jCpw2lbXdd/SQ71tFmMl5aMmo62uU2P1A00HGyiCVeJpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdkqreIHcB/Dk6L8FB6WysMOv3Rdx0f7RMPQleS0UBpknAXJQC
	ZyzlQt2S1kPX9pZ+yNvNFkQEHCT/Z2kSXnk6xtSdRqcGHaoSgJRpL6yj
X-Gm-Gg: AeBDietNxuQkxmP5qGPwoNrfk+JD05cRlZrQE+i8c7QarHeBpkzGPW/TCpdLwGJ45rY
	uTXPmRcIcI+hq+GbRGBBSMvrL5NEG23cyxxA2TZRMjuhiDTI143ICi0Gp1tmnF6zWt4P/CxCNr7
	4kdYh4JdIvMAy5q8nqiJmHD764aZx2nFFrt1IuUbyQZjCsecPTUeZxK0h/AfpKBwCwZIKPwmM8H
	yduLtlnuCBzoI/5j1lyPOTp/LPJRR3BSW1eQWy/oSc16e2E0W5GEs/T/kIeA/AwDhvcxgozHxk1
	8hazS2XXuddEEU986GO3r2NWItXiAXV+QoZHnfEcvIouiAe44wRexuDGMK9DkZMuAdAEIcHvVPA
	aRMCGKFLqwTLhdnA3COlWjzyl6XpRlVhPlRoF+Ym7OyZPtak46ZZYoM9Vf9C7/tmutR9jxrHjwu
	AntvYZgsb4ECWVuhoBinZtWwTgW9c=
X-Received: by 2002:a17:903:110c:b0:2b2:4194:952a with SMTP id d9443c01a7336-2b5f9f816femr39399565ad.6.1776533329786;
        Sat, 18 Apr 2026 10:28:49 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3bfsm69694965ad.7.2026.04.18.10.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:28:49 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: linkinjeon@kernel.org,
	smfrench@gmail.com
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 0/2] ksmbd: connection accounting and session teardown fixes
Date: Sun, 19 Apr 2026 02:28:42 +0900
Message-ID: <20260418172844.1333378-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[chromium.org,talpey.com,vger.kernel.org,suse.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238600-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charsyam@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8C2F421CEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two independent correctness fixes in the ksmbd server.

 1/2 ksmbd_tcp_new_connection() does not decrement active_num_conn on
     the alloc_transport() failure path, so repeated allocation
     failures monotonically inflate the counter until max_connections
     is reached and new clients are refused indefinitely.  This is
     the remaining half of the same family of accounting bugs
     addressed by 77ffbcac4e56 ("smb: server: fix leak of
     active_num_conn in ksmbd_tcp_new_connection()"), which only
     closed the kthread_run() failure path.  Reproduced under a debug
     build that forces alloc_transport() to return NULL for a bounded
     number of calls; details in the commit log.

 2/2 ksmbd_conn_wait_idle_sess_id() stores its per-connection
     threshold (rcount) in cross-iteration state, so whether a given
     sibling connection is compared against the loose (< 2) or the
     strict (< 1) threshold is decided by hash iteration order
     relative to curr_conn.  Connections visited after curr_conn can
     slip through the idle check while still processing requests
     against the same session, reopening the teardown race
     destroy_previous_session() was meant to close.  This is a
     code-inspection fix; the iteration-order dependency makes a
     targeted reproducer impractical.

The two patches are independent; the series order is not significant.

DaeMyung Kang (2):
  ksmbd: fix active_num_conn leak when alloc_transport() fails
  ksmbd: reset rcount per connection in ksmbd_conn_wait_idle_sess_id()

 fs/smb/server/connection.c    | 5 ++---
 fs/smb/server/transport_tcp.c | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

--
2.43.0

