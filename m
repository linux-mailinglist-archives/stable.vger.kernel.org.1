Return-Path: <stable+bounces-167080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D710B21911
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 01:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDB3461B7A
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 23:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4765A1D63E6;
	Mon, 11 Aug 2025 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="se9CmQoN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4713AC1;
	Mon, 11 Aug 2025 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954149; cv=none; b=QZsCfvnEQAAPU46GgfdShYuQ3etFkq+pyZ6C0zooE9jT1lpfTzV5CYq33bshzQ5wkwnCBGirIY74irZ2OOPT6q+pi2zun4US4A2OX5hDq/jFo1gSdxzwK3cpEQsBcW/Lf2tk3Oa5vRYOvQH7e15XzLP1SdsmNaZ+HRx7R2L6skM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954149; c=relaxed/simple;
	bh=1pKV18wtQp9F8carNv7T3XI0XD9+rp+HBBUcxtkB2pU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=lVouFPO4jUi43Xh5cxsKF+qFv+kMp8QFcU97zV/WcsA1x+wr4s17w7kqXmxi8K46N20Mgrzcl1pYnTKyQK8oFk7WrVZP5J8czGAa1ZSWv2+47q8sj9n0CYFN8cToiNyVgG+YSvTQCzLxweCKs77rstIoUsosTX6LASEXivUfbng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=se9CmQoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8A2C4CEED;
	Mon, 11 Aug 2025 23:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754954148;
	bh=1pKV18wtQp9F8carNv7T3XI0XD9+rp+HBBUcxtkB2pU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=se9CmQoNCSVQpE3WebAh44ce2vrqliXTZqypiSHk4/BV2pzCuMJxB0DKt0C6TyUQE
	 0veHrjEImENM2dfgCd5lIpS3/o5JEF/4+Kgtm7VAqsWSFnys7ZzHKzrTbFiqzZBCAQ
	 OH+cLNr61dnlzgda8DrIHPbiX+m6Qw9yWf+xXBQPmOvPcYS9hWAdq0UlmzV2hsGvsE
	 r8wYCjbh2tO84i2ar0VrgNfv31XPKbqaFScDfdkFFf2jg02CteYtiu0YHUyQoleIgb
	 MU+VHthjWglcyEpqOoWI3PUruypdHt1AKahDnocFVuJUnkDsbwI0tV47xJF0VAafhw
	 sRKGXDBUSh8Ww==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 01:15:43 +0200
Message-Id: <DBZZBNP278NH.2DR4PMWX9HKST@kernel.org>
Subject: Re: [PATCH] rust: devres: fix leaking call to devm_add_action()
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250811214619.29166-1-dakr@kernel.org>
 <DBZYO8O9YTO3.10MKWPYN8YEOB@kernel.org>
In-Reply-To: <DBZYO8O9YTO3.10MKWPYN8YEOB@kernel.org>

On Tue Aug 12, 2025 at 12:45 AM CEST, Benno Lossin wrote:
> On Mon Aug 11, 2025 at 11:44 PM CEST, Danilo Krummrich wrote:
>> When the data argument of Devres::new() is Err(), we leak the preceding
>> call to devm_add_action().
>>
>> In order to fix this, call devm_add_action() in a unit type initializer =
in
>> try_pin_init!() after the initializers of all other fields.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: f5d3ef25d238 ("rust: devres: get rid of Devres' inner Arc")
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  rust/kernel/devres.rs | 17 ++++++++++-------
>>  1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>> index da18091143a6..bfccf4177644 100644
>> --- a/rust/kernel/devres.rs
>> +++ b/rust/kernel/devres.rs
>> @@ -119,6 +119,7 @@ pub struct Devres<T: Send> {
>>      // impls can be removed.
>>      #[pin]
>>      inner: Opaque<Inner<T>>,
>> +    _add_action: (),
>>  }
>> =20
>>  impl<T: Send> Devres<T> {
>> @@ -140,7 +141,15 @@ pub fn new<'a, E>(
>>              dev: dev.into(),
>>              callback,
>>              // INVARIANT: `inner` is properly initialized.
>> -            inner <- {
>> +            inner <- Opaque::pin_init(try_pin_init!(Inner {
>> +                    devm <- Completion::new(),
>> +                    revoke <- Completion::new(),
>> +                    data <- Revocable::new(data),
>> +            })),
>> +            // TODO: Replace with "initializer code blocks" [1] once av=
ailable.
>> +            //
>> +            // [1] https://github.com/Rust-for-Linux/pin-init/pull/69
>> +            _add_action: {
>>                  // SAFETY: `this` is a valid pointer to uninitialized m=
emory.
>>                  let inner =3D unsafe { &raw mut (*this.as_ptr()).inner =
};
>> =20
>> @@ -153,12 +162,6 @@ pub fn new<'a, E>(
>>                  to_result(unsafe {
>>                      bindings::devm_add_action(dev.as_raw(), Some(callba=
ck), inner.cast())
>>                  })?;
>
> I have some bad news, I think this is also wrong: if the
> `devm_add_action` fails, we never drop the contents of `inner`, since
> the destructor of `Opaque` does nothing and we never finished
> construction of `Devres`, so its `Drop` will never be called.

Good catch! For some reason I already had UnsafePinned in mind, but it's st=
ill a
TODO to replace the Opaque with UnsafePinned.

> One solution would be to use `pin_chain` on the initializer for `Inner`
> (not opaque). Another one would be to not use opaque, `UnsafePinned`
> actually looks like the better fit for this use-case.

Yeah, the problem should go away with UnsafePinned. Maybe, until we have it=
, we
can just do the following:

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index bfccf4177644..1981201fa7f9 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -161,6 +161,9 @@ pub fn new<'a, E>(
                 //    live at least as long as the returned `impl PinInit<=
Self, Error>`.
                 to_result(unsafe {
                     bindings::devm_add_action(dev.as_raw(), Some(callback)=
, inner.cast())
+                }).inspect_err(|_| {
+                    // SAFETY: `inner` is valid for dropping.
+                    unsafe { core::ptr::drop_in_place(inner) };
                 })?;
             },
         })

