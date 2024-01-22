Return-Path: <stable+bounces-13541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B68837C84
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC0B287BB8
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F8D135A44;
	Tue, 23 Jan 2024 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGh+v0oo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1909A13541C;
	Tue, 23 Jan 2024 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969652; cv=none; b=C17soy37ermYrBUzdx6k2q0OqqiIZs9naDSL8k9tDKShUrWPqVivw53GOLzSm7LqF4TSTD4bbnT0BrMmlW2IWA7EvYR8cfMp1O6bln6kAinJu53n/d27YFPHA+WTtE1uDBR4A4gkBOrtzAtyW50pERaxR/siVzL5nacziWw5Mec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969652; c=relaxed/simple;
	bh=UVj/X4Ef3VwNvMXFR6VMRdzAR/EEsON8HbK06X2TILo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqH+02sSZBaqAU30OQ2ahiShyplZrVy3pftzvNyu3noF3X2/y2EJ0Nh0o0anbUm+V1AtsI36sBdps8CkVF9WCMgwMbJAj5y3JlPGnRRqJabEXcYbNmsQEXD0/uwEzfnYc7jzDBCaLzPhRsDeKc7h0df8+JW7g7c2SSuif4b3nis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGh+v0oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4516C433F1;
	Tue, 23 Jan 2024 00:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969651;
	bh=UVj/X4Ef3VwNvMXFR6VMRdzAR/EEsON8HbK06X2TILo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGh+v0ooQo+t5Aa8J61kWOICGBVYdIjaG0p23dEn0pVZOG3h5MOQPlTSsbQamPCJE
	 /fvsCfVAAn30EA8vxN6r+asLs/qhuzew9+TXl0MN38W5kNj0QhdLf0FAhljEf0HlrO
	 NeJBtF6SBhoziciwLfEkbR88i7OewtRLM3rSBh5o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Maurer <mmaurer@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.7 384/641] rust: Ignore preserve-most functions
Date: Mon, 22 Jan 2024 15:54:48 -0800
Message-ID: <20240122235829.968546534@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Maurer <mmaurer@google.com>

commit bad098d76835c1379e1cf6afc935f8a7e050f83c upstream.

Neither bindgen nor Rust know about the preserve-most calling
convention, and Clang describes it as unstable. Since we aren't using
functions with this calling convention from Rust, blocklist them.

These functions are only added to the build when list hardening is
enabled, which is likely why others didn't notice this yet.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20231031201945.1412345-1-mmaurer@google.com
[ Used Markdown for consistency with the other comments in the file. ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/bindgen_parameters |    4 ++++
 1 file changed, 4 insertions(+)

--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -20,3 +20,7 @@
 
 # `seccomp`'s comment gets understood as a doctest
 --no-doc-comments
+
+# These functions use the `__preserve_most` calling convention, which neither bindgen
+# nor Rust currently understand, and which Clang currently declares to be unstable.
+--blocklist-function __list_.*_report



