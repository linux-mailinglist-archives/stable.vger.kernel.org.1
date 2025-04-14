Return-Path: <stable+bounces-132450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3B3A880A7
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CC8175582
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75A72BE7DB;
	Mon, 14 Apr 2025 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKHWmdSy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE252BE7B8;
	Mon, 14 Apr 2025 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634507; cv=none; b=G3lKqpiVD97tjfDLNjzE1rwPFF3EpEaiB/a6wiqKdO1798iEfYGU9P7G3E664Sb1m3RYQ+4UJ70Y+DpKNlqMyJ8uBBeepGz9e36Q/WgAfS104I7Mo+iUf98CD3ntlbtzboE2IsEkCKU3t8HKI3Z9Lzr5ZLk+e0Aeh8BOfeOP/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634507; c=relaxed/simple;
	bh=3BlNmQpMp82xJdAZ0Bho2rJ8qJsNAxUz1OgSOw9idJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwWALlSlk4nZL1jnYizfCxSQyQZsmD/YngeikZiOL0V+AMWrVZGBhQ96ECFWOyrAqjWfBWOm8Qw0RFla9Nhncr4oOhm7Vv2qFnNXeAJv+MrpRgdpnexlL14HsBYr5dbJrRPKS6l5cYaHPkzK/iz7F754wDyX8Oq1BrT3irD5dY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKHWmdSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4082C4CEE2;
	Mon, 14 Apr 2025 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744634506;
	bh=3BlNmQpMp82xJdAZ0Bho2rJ8qJsNAxUz1OgSOw9idJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKHWmdSyJPedYFPNxldVA2LFgAkClYqz35karquJkKls9Qicneob6E3Pxfl6Oa5oE
	 Tg8CdWKsVnxCoiiA8994/hHfLGB1frgaaPr5fkTJnf8pIogEmq4v7Srb80rwFUmlBM
	 TqSqWp1o3fCHP487pbfILQxw0iqWTwjLnWwx/+z0NlHK2yyy7lszo4dBsuiG2B7JrM
	 +Z8QDyXNXN9ALILXlxZyNCGqmMTesHOyRfy6KM/ngHyIZCKgz7k1VMHwhApNf9fyno
	 G8JsK0v2JC3N11qrF6EaSkEMNApyij81rz5Yaz8SzqtUO4AdXrri9DCWQ16YAPqw7i
	 P5MjfMBm5yFsA==
Date: Mon, 14 Apr 2025 14:41:41 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] rust: Use `ffi::c_char` type in firmware abstraction
 `FwFunc`
Message-ID: <Z_0ChQQkMtHoTo1C@cassiopeiae>
References: <20250413-rust_arm_fix_fw_abstaction-v3-1-8dd7c0bbcd47@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413-rust_arm_fix_fw_abstaction-v3-1-8dd7c0bbcd47@gmail.com>

On Sun, Apr 13, 2025 at 09:26:56PM +0200, Christian Schrefl wrote:
> The `FwFunc` struct contains an function with a char pointer argument,
> for which a `*const u8` pointer was used. This is not really the
> "proper" type for this, so use a `*const kernel::ffi::c_char` pointer
> instead.

With the following changes, applied to driver-core-linus, thanks!

  * add firmware prefix to commit subject

- Danilo

