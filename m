Return-Path: <stable+bounces-197515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D250DC8F7E6
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 17:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C822C4E035B
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6043D2D3A6A;
	Thu, 27 Nov 2025 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXU6cyri"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7835331A07C
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764260604; cv=none; b=OUHk3G6iZbObYVhpv06pDHAnkcOBBXTIQCmtLwv/nTDQjUMPBxMR8ha6SmnVkGQQGPUDJkhdPvtLWhjO1cbyx8CyEJrEeO99NfH9oJ/sGZvR1ww90n/VE0jl4sG6Trh2TQdbdd79NteokIyNrmMaEzIlCmwFMZ4/B8kiY7WEL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764260604; c=relaxed/simple;
	bh=pNR7D+TTJBjGKiiyUlc/Pf9HJdEzwSoj6SuAHFN2e2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeJxtXIbzhW2qSJmV7Gn7FrG+n1CFjkAC4clc2G0tNnQBIRFnH1R/esrYkKyCdbkEeWI/EUHekczgCYqPXC0qp6VzKNjuNLt2hA3125BtztdQuwHdu5iVUn4Q3vx56sdfdCnV3cwnixIrMvSCTRZJLHCAxWc7mjHk4pzykWkQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXU6cyri; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-595819064cdso1399717e87.0
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 08:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764260599; x=1764865399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJKUTXxj8oW3QwBeXifjlm7tJpNcI4cl2p7YPGSDDcQ=;
        b=HXU6cyrim4D93vikc/JSqTpU7fOU4+zEr+YJN9XJG0gryx63Fhk8Qhf1fduS673C6k
         y9v5ESvpBoMLnpp0OvaKm2euTU2YPt7i9V7BvKMPXwWupZGMOF3bElxcpIyxD0qttLI+
         N9hIEtoa37MQrU9Ss/hCUJsvaFf47yf7XM4QScYnyB0MgbxrsalS19T7os8Fkh1KoEc0
         8LryDX79Vg72l9ArdA9RInYEegRIbIp86QQU6B+KE/cuyW9mGTT2Qh8nSrGXSKrxRT+C
         bcjIJLkBsg7rLWRXcAC24j1euAvggulbLQke2CykkkimxRF65Uk8sOavgdI07LW8iVRf
         rUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764260599; x=1764865399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJKUTXxj8oW3QwBeXifjlm7tJpNcI4cl2p7YPGSDDcQ=;
        b=l1g0ytpNi6XU/zn025JIKkaZx+qmgLcgIsaRFxuzkuycJocMdVOAfMLdWktStn32Uq
         YIzFadx+NYUGhUNF/nsJQuTdKRIvQ1BDkYC0tFvlKUCwLu8nrKbiM+sdYauzm7OQm5xt
         eFQ7d/rzCN13R6xlXBtNYEH9RT1qKnvYDrEWww/OyHRsWPxd9iwvwHJfDUF2QGT+rsG/
         Ri0Im4/A6RXogGKD8Ob2eQNNu6ejkV8PILu4LEi+Skr+Nmfc+mU3+r1Hv+8bcrPZW7DT
         157XI1ROfHsQpsTKn1fJvijTX/XhYoeV2/Iude/KezNr/2ftQUEikKRwt8vEQ4I7jN6q
         Pm/w==
X-Gm-Message-State: AOJu0YyBl1m/dOiiU8bZ8YUrtyZ5u3D9PTh0Dgsxo1QJDfs7twnn6dxT
	gPMSj3untw5/pneGTWbQv5+pOBt4phe95E1BpjuRIOlURPmf9ZoqtksRAbtRrKMyOX2BUA==
X-Gm-Gg: ASbGncsj1bfe1G8cmNnyCodiS5SZSD/CxrnwlUZkWwpTUvk75UF3rzGhB4svaxs8ofE
	QUsKC7BYOCQhjdVshJZ/m+jJd0NpD1iP42FdBs2UC4t+mRaFodq2DQA55ODb1LYJ89YNEU1+KqU
	w3J/O2SGlNJe8JcRdaX8VGGSBegG/8Nuv88SwMzwErwDxiFXHFg4aaaocGuWVnjxJY1L2Oti7lR
	DxDGpfUap5k4e9hsA4ORN09bnba5ZQ/SeARx+t/6rWXK0N+5mrXPaxgrM7Q+sUvn+ljnV2vqUGu
	lZOuoRrt5RFL+aH1jFGi+odeke9ggke0pXdd0DISZrCW+fuq75CgVhezobGNJTP00bJixl5WImJ
	RuBiokNVWLcz453F2DZ8uxNAeVUA0KsfVuloBgBh65SeTng69YRX6+uLydzxfTXKWaLuZ3eov+f
	bsLUCg9tIOKKjctrS/EQ==
X-Google-Smtp-Source: AGHT+IHWThZT2IhgINOAb1vObq596aimRrqw0VBy+vwKTlft5laJGKAnkt0Wk8x+sRxaQF5pz/mWMA==
X-Received: by 2002:a05:6512:3b9d:b0:595:9195:338b with SMTP id 2adb3069b0e04-596a3794b94mr7873039e87.20.1764260599009;
        Thu, 27 Nov 2025 08:23:19 -0800 (PST)
Received: from cherrypc.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bfa43eefsm505644e87.65.2025.11.27.08.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 08:23:18 -0800 (PST)
From: Nazar Kalashnikov <sivartiwe@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <sivartiwe@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Sean Heelan <seanheelan@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH v2 6.6] ksmbd: fix use-after-free in session logoff
Date: Thu, 27 Nov 2025 19:23:37 +0300
Message-ID: <20251127162338.7276-1-sivartiwe@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Heelan <seanheelan@gmail.com>

commit 2fc9feff45d92a92cd5f96487655d5be23fb7e2b upstream.

The sess->user object can currently be in use by another thread, for
example if another connection has sent a session setup request to
bind to the session being free'd. The handler for that connection could
be in the smb2_sess_setup function which makes use of sess->user.

Signed-off-by: Sean Heelan <seanheelan@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Nazar Kalashnikov <sivartiwe@gmail.com>
---
v2: Fix duplicate From: header
Backport fix for CVE-2025-37899
 fs/smb/server/smb2pdu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 9f64808c7917..a819f198c333 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2255,10 +2255,6 @@ int smb2_session_logoff(struct ksmbd_work *work)
 	sess->state = SMB2_SESSION_EXPIRED;
 	up_write(&conn->session_lock);
 
-	if (sess->user) {
-		ksmbd_free_user(sess->user);
-		sess->user = NULL;
-	}
 	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_SETUP);
 
 	rsp->StructureSize = cpu_to_le16(4);
-- 
2.43.0


